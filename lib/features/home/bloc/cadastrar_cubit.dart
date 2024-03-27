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
              id: const Uuid().v1(),
              authorizationsId: [""],
              name: '',
              thirdCompanyId: '',
              visitorCompany: '',
              role: '',
              number: 0,
              bloodType: 'A+',
              cpf: '-',
              email: '-',
              area: 'Ambos',
              lastAreaFound: '',
              lastTimeFound: DateTime.now(),
              isBlocked: false,
              documentsOk: false,
              blockReason: '-',
              status: '-',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
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
        print(e.toString());
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: e.toString(),
          ));
        }
      }
    }
  }

  //updateAuthorizationType updating employee.area
  void updateAuthorizationType(String authorizationType) {
    final employee = state.employee.copyWith(area: authorizationType);
    emit(state.copyWith(employee: employee));
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

  void addDocument(PlatformFile file, DateTime expirationDate, String type) {
    //turn file to base64
    final String base64 = base64Encode(file.bytes!);

    final updatedDocuments = List<Document>.from(state.documents)
      ..add(Document(
        id: const Uuid().v4(),
        type: type,
        employeeId: state.employee.id,
        expirationDate: expirationDate,
        path: base64,
        status: 'pending',
      ));
    emit(state.copyWith(documents: updatedDocuments));
  }

  Future<void> pickImage() async {
    Employee employee = state.employee;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
      compressionQuality: 90,
    );

    //receive the bytes of the image, convert it to base64 and update the state
    if (result != null) {
      Uint8List bytes = result.files.first.bytes!;
      String base64Image = base64Encode(bytes);
      final picture = state.picture.copyWith(base64: base64Image);
      emit(state.copyWith(picture: picture, employee: employee));
    }
  }

  //add third company name to the employee
  void addThirdCompany(String thirdCompany) {
    final employee = state.employee.copyWith(thirdCompanyId: thirdCompany);
    emit(state.copyWith(employee: employee));
    checkCadastroHabilitado();
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

  //updateEmail, updateCpf and updateRole follow the same pattern
  void updateEmail(String email) {
    final employee = state.employee.copyWith(email: email);
    if (!isClosed) {
      emit(state.copyWith(employee: employee));
      checkCadastroHabilitado();
    }
  }

  void updateCpf(String cpf) {
    final employee = state.employee.copyWith(cpf: cpf);
    if (!isClosed) {
      emit(state.copyWith(employee: employee));
      checkCadastroHabilitado();
    }
  }

  void updateRole(String role) {
    final employee = state.employee.copyWith(role: role);
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
          id: const Uuid().v1(),
          authorizationsId: [""],
          name: '',
          thirdCompanyId: '',
          visitorCompany: '',
          role: '',
          number: 0,
          bloodType: 'A+',
          cpf: '-',
          email: '-',
          area: 'Ambos',
          lastAreaFound: '',
          lastTimeFound: DateTime.now(),
          isBlocked: false,
          documentsOk: false,
          blockReason: '-',
          status: '-',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
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

  void createEvent(String name, String cpf, String email, String funcao,
      String empresa, String bloodType) async {
    fetchNumero();
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
      emit(state.copyWith(
        employee: state.employee.copyWith(
          name: name,
          cpf: cpf,
          email: email,
          role: funcao,
          thirdCompanyId: empresa,
          bloodType: bloodType,
        ),
        event: event,
      ));
    }
    try {
      //await eventRepository.createEvent(event);
      print('Event created');
      SimpleLogger.info('Event created');
      if (!isClosed) {
        createPicture();
      }
    } catch (e) {
      print(e.toString());
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
    if (state.picture.base64.isEmpty || state.picture.base64 == '-') {
      if (!isClosed) {
        createDocuments();
      }
    } else {
      if (!isClosed) {
        emit(state.copyWith(
            picture: state.picture
                .copyWith(status: 'created', employeeId: state.employee.id)));
        try {
          await pictureRepository.createEmployeePicture(state.picture);
          print(documentRepository);
          SimpleLogger.info('Picture created');
          if (!isClosed) {
            createDocuments();
          }
        } catch (e) {
          print(e.toString());
          SimpleLogger.warning('Error cadastrar_cubit createPicture: $e');
          if (!isClosed) {
            emit(state.copyWith(
              errorMessage: e.toString(),
            ));
          }
        }
      }
    }
  }

  //create documents, for each Document in state.documents, create a document with DocumentRepository passing the document
  Future<void> createDocuments() async {
    print("createDocuments");
    if (state.documents.isEmpty) {
      if (!isClosed) {
        createEmployee();
      }
    }
    if (!isClosed) {
      for (var document in state.documents) {
        try {
          print('Creating document');
          await documentRepository.createDocument(document);
          SimpleLogger.info('Document created');
        } catch (e) {
          print(e.toString());
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
      final employee = state.employee.copyWith(documentsOk: true);
      emit(state.copyWith(employee: employee));
      try {
        await employeeRepository.createEmployee(state.employee);
        SimpleLogger.info('Employee created');
        print('Employee created');
        emit(state.copyWith(employeeCreated: true));
      } catch (e) {
        SimpleLogger.warning('Error cadastrar_cubit createEmployee: $e');
        print(e.toString());
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
        state.employee.area.isNotEmpty;
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
