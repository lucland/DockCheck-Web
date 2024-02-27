import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dockcheck_web/repositories/event_repository.dart';
import 'package:dockcheck_web/repositories/picture_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../models/document.dart';
import '../../../models/event.dart';
import '../../../models/employee.dart';
import '../../../models/picture.dart';
import '../../../repositories/document_repository.dart';
import '../../../repositories/employee_repository.dart';
import '../../../services/local_storage_service.dart';
import '../../../utils/simple_logger.dart';
import 'cadastrar_state.dart';

class CadastrarCubit extends Cubit<CadastrarState> {
  final EmployeeRepository employeeRepository;
  final EventRepository eventRepository;
  final PictureRepository pictureRepository;
  final DocumentRepository documentRepository;
  final LocalStorageService localStorageService;

  @override
  bool isClosed = false;
  late StreamSubscription scanSubscription;
  bool isStreaming = false;

  CadastrarCubit(this.employeeRepository, this.localStorageService,
      this.eventRepository, this.pictureRepository, this.documentRepository)
      : super(
          CadastrarState(
            numero: 0,
            employee: Employee(
              id: '',
              authorizationsId: [""],
              name: '',
              thirdCompanyId: '',
              visitorCompany: '',
              role: '',
              number: 0,
              bloodType: '-',
              cpf: '-',
              email: '-',
              area: 'Praça de Máquinas',
              lastAreaFound: '',
              lastTimeFound: DateTime.now(),
              isBlocked: false,
              documentsOk: false,
              blockReason: '-',
              status: '-',
            ),
            event: Event(
              id: const Uuid().v4(),
              employeeId: '-',
              timestamp: DateTime.now(),
              projectId: '-',
              action: 0,
              sensorId: '-',
              status: '-',
              beaconId: '-',
            ),
            picture: Picture(
              id: const Uuid().v4(),
              employeeId: '-',
              base64: '',
              docPath: '',
              status: '-',
            ),
            documents: [],
            isLoading: true,
            employeeCreated: false,
            cadastroHabilitado: false,
            nrTypes: [],
            selectedNr: '',
          ),
        );

  void fetchNumero() async {
    if (!isClosed) {
      try {
        var numero = await employeeRepository.getLastEmployeeNumber();
        //parse the numero string to int
        var numeroInt = int.parse(numero);

        final employee = state.employee.copyWith(number: numeroInt + 1);
        if (!isClosed) {
          emit(state.copyWith(
              employee: employee, isLoading: false, numero: numeroInt + 1));
        }
      } catch (e) {
        SimpleLogger.warning('Error during data synchronization: $e');
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: e.toString(),
          ));
        }
      }
    }
  }

  void addNrType(String nrType) {
    //if nrtype is not in the list, add it
    if (state.nrTypes.contains(nrType)) {
      return;
    }
    final updatedNrTypes = List<String>.from(state.nrTypes)..add(nrType);
    emit(state.copyWith(nrTypes: updatedNrTypes));
  }

  void removeNrType(String nrType) {
    final updatedNrTypes = List<String>.from(state.nrTypes)..remove(nrType);
    emit(state.copyWith(nrTypes: updatedNrTypes));
  }

  void updateSelectedNr(String nrType) {
    emit(state.copyWith(selectedNr: nrType));
  }

  void addDocument(Document document) {
    final updatedDocuments = List<Document>.from(state.documents)
      ..add(document);
    emit(state.copyWith(documents: updatedDocuments));
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    //receive the bytes of the image, convert it to base64 and update the state
    if (result != null) {
      Uint8List bytes = result.files.first.bytes!;
      String base64Image = base64Encode(bytes);
      final picture = state.picture.copyWith(base64: base64Image);
      emit(state.copyWith(picture: picture));
    }
  }

  void removeImage() {
    final picture = state.picture.copyWith(base64: '');
    emit(state.copyWith(picture: picture));
  }

  void updateBloodType(String bloodType) {
    final employee = state.employee.copyWith(bloodType: bloodType);
    if (!isClosed) {
      emit(state.copyWith(employee: employee));
      checkCadastroHabilitado();
    }
  }

  void updateNome(String nome) {
    final employee = state.employee.copyWith(name: nome, status: 'created');
    if (!isClosed) {
      emit(state.copyWith(employee: employee));
      checkCadastroHabilitado();
    }
  }

  void updateEmpresa(String empresa) {
    final employee = state.employee.copyWith(thirdCompanyId: empresa);
    if (!isClosed) {
      emit(state.copyWith(employee: employee));
      checkCadastroHabilitado();
    }
  }
  // Similarly, other update methods follow the same pattern

  void resetState() {
    if (!isClosed) {
      emit(state.copyWith(
        employee: Employee(
          id: '',
          authorizationsId: [""],
          name: '',
          thirdCompanyId: '',
          visitorCompany: '',
          role: '',
          number: 0,
          bloodType: '-',
          cpf: '-',
          email: '-',
          area: 'Praça de Máquinas',
          lastAreaFound: '',
          lastTimeFound: DateTime.now(),
          isBlocked: false,
          documentsOk: false,
          blockReason: '-',
          status: '-',
        ),
        event: Event(
          id: const Uuid().v4(),
          employeeId: '-',
          timestamp: DateTime.now(),
          projectId: '-',
          action: 0,
          sensorId: '-',
          status: '-',
          beaconId: '-',
        ),
        isLoading: true,
        employeeCreated: false,
        cadastroHabilitado: false,
        nrTypes: [],
        documents: [],
        picture: Picture(
          id: const Uuid().v4(),
          employeeId: '-',
          base64: '',
          docPath: '',
          status: '-',
        ),
        selectedNr: '',
      ));
    }
  }

  void createEvent() async {
    final event = state.event.copyWith(
      employeeId: state.employee.id,
      timestamp: DateTime.now(),
      projectId: '1',
      action: 1,
      sensorId: '1',
      status: 'created',
      beaconId: '1',
    );
    if (!isClosed) {
      emit(state.copyWith(event: event));
    }
    try {
      await eventRepository.createEvent(event);
      if (!isClosed) {
        createPicture();
      }
    } catch (e) {
      SimpleLogger.warning('Error cadastrar_cubit createEvent: $e');
      if (!isClosed) {
        emit(state.copyWith(
          errorMessage: e.toString(),
        ));
      }
    }
  }

//create picture with PictureRepository passing state.picture
  Future<void> createPicture() async {
    if (!isClosed) {
      try {
        await pictureRepository.createEmployeePicture(state.picture);
        if (!isClosed) {
          createDocuments();
        }
      } catch (e) {
        SimpleLogger.warning('Error cadastrar_cubit createPicture: $e');
        if (!isClosed) {
          emit(state.copyWith(
            errorMessage: e.toString(),
          ));
        }
      }
    }
  }

  //create documents, for each Document in state.documents, create a document with DocumentRepository passing the document
  Future<void> createDocuments() async {
    if (!isClosed) {
      for (var document in state.documents) {
        try {
          await documentRepository.createDocument(document);
        } catch (e) {
          SimpleLogger.warning('Error cadastrar_cubit createDocuments: $e');
          if (!isClosed) {
            emit(state.copyWith(
              errorMessage: e.toString(),
            ));
          }
        } finally {
          if (!isClosed) {
            createEmployee();
          }
        }
      }
    }
  }

  Future<void> createEmployee() async {
    if (!isClosed) {
      final employee =
          state.employee.copyWith(id: const Uuid().v1(), documentsOk: true);
      emit(state.copyWith(employee: employee));
      try {
        await employeeRepository.createEmployee(state.employee);
        emit(state.copyWith(employeeCreated: true));
      } catch (e) {
        SimpleLogger.warning('Error cadastrar_cubit createEmployee: $e');
        if (!isClosed) {
          emit(state.copyWith(
            errorMessage: e.toString(),
          ));
        }
      }
    }
  }

  void checkCadastroHabilitado() {
    if (state.employee.visitorCompany.isNotEmpty) {
      if (visitorChecksPassed()) {
        if (!isClosed) {
          emit(state.copyWith(cadastroHabilitado: true));
        }
      } else {
        if (!isClosed) {
          emit(state.copyWith(cadastroHabilitado: false));
        }
      }
    } else {
      if (userChecksPassed()) {
        if (!isClosed) {
          emit(state.copyWith(cadastroHabilitado: true));
        }
      } else {
        if (!isClosed) {
          emit(state.copyWith(cadastroHabilitado: false));
        }
      }
    }
  }

  bool userChecksPassed() {
    return state.employee.name.isNotEmpty &&
        state.employee.role.isNotEmpty &&
        state.employee.thirdCompanyId.isNotEmpty &&
        state.employee.area.isNotEmpty &&
        state.picture.base64.isNotEmpty;
  }

  bool visitorChecksPassed() {
    return state.employee.name.isNotEmpty &&
        state.employee.visitorCompany.isNotEmpty;
  }

  // Closing the cubit
  @override
  Future<void> close() {
    if (isStreaming) {
      scanSubscription.cancel();
    }
    return super.close();
  }
}
