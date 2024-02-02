// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:uuid/uuid.dart';

import '../../../models/event.dart';
import '../../../models/user.dart';
import '../../../repositories/user_repository.dart';
import '../../../services/local_storage_service.dart';
import '../../../utils/simple_logger.dart';
import 'cadastrar_state.dart';

class CadastrarCubit extends Cubit<CadastrarState> {
  final UserRepository userRepository;
  final LocalStorageService localStorageService;

  @override
  bool isClosed = false;
  late StreamSubscription scanSubscription;
  bool isStreaming = false;

  CadastrarCubit(this.userRepository, this.localStorageService)
      : super(
          CadastrarState(
            numero: 0,
            user: User(
              id: '',
              authorizationsId: [""],
              name: '',
              company: '',
              role: '',
              project: '-',
              number: 0,
              bloodType: '-',
              cpf: '-',
              aso: DateTime.now(),
              asoDocument: '-',
              hasAso: false,
              nr34: DateTime.now(),
              nr34Document: '-',
              hasNr34: false,
              nr35: DateTime.now(),
              nr35Document: '-',
              hasNr35: false,
              nr33: DateTime.now(),
              nr33Document: '-',
              hasNr33: false,
              nr10: DateTime.now(),
              nr10Document: '-',
              hasNr10: false,
              email: '-',
              area: 'Praça de Máquinas',
              isAdmin: false,
              isVisitor: false,
              isPortalo: false,
              isCrew: false,
              isOnboarded: false,
              isBlocked: false,
              blockReason: '-',
              iTag: '',
              picture: '',
              typeJob: '-',
              startJob: DateTime.now(),
              endJob: DateTime.now(),
              username: "",
              salt: '',
              hash: '',
              status: '-',
            ),
            evento: Event(
              id: Uuid().v4(),
              portalId: '-',
              userId: '-',
              timestamp: DateTime.now(),
              beaconId: '-',
              vesselId: '-',
              action: 0,
              justification: '-',
              status: '-',
            ),
          ),
        );

  void fetchNumero() async {
    if (!isClosed) {
      try {
        var numero = await userRepository.getLastUserNumber();
        final user = state.user.copyWith(number: numero);
        if (!isClosed) {
          emit(state.copyWith(user: user, isLoading: false, numero: numero));
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

  Future<void> pickImage() async {
    /* final image = await ImagePickerPlugin().getImageFromSource(source: XFile source);
    if (image != null) {
      final imagePath = image.path;
      updatePicture(imagePath,
          quality: 40); // Defina a qualidade desejada (entre 0 e 100)
    }*/
  }

  void removeImage() {
    // Logic to remove the image
    // Update the state with the new image
    final user = state.user.copyWith(picture: '');
    if (!isClosed) {
      emit(state.copyWith(user: user));
    }
  }

  void updateBloodType(String bloodType) {
    final user = state.user.copyWith(bloodType: bloodType);
    if (!isClosed) {
      emit(state.copyWith(user: user));
      checkCadastroHabilitado();
    }
  }

  void updateNome(String nome) {
    final user = state.user.copyWith(name: nome, status: 'created');
    if (!isClosed) {
      // o problema está dentro dos métodos
      emit(state.copyWith(user: user));
      checkCadastroHabilitado();
    }
  }

  void updateFuncao(String funcao) {
    final user = state.user.copyWith(role: funcao);
    if (!isClosed) {
      emit(state.copyWith(user: user));
      checkCadastroHabilitado();
    }
  }

  void updateEmail(String email) {
    final user = state.user.copyWith(email: email);
    if (!isClosed) {
      emit(state.copyWith(user: user));
      checkCadastroHabilitado();
    }
  }

  void updateEmpresa(String empresa) {
    final user = state.user.copyWith(company: empresa);
    if (!isClosed) {
      emit(state.copyWith(user: user));
      checkCadastroHabilitado();
    }
  }

  void updatePassword(String password) {
    final user = state.user.copyWith(salt: password, hash: '');
    if (!isClosed) {
      emit(state.copyWith(user: user));
    }
  }

  void updateUserVisitor(String usuario) {
    final user = state.user.copyWith(username: usuario);
    if (!isClosed) {
      emit(state.copyWith(user: user));
    }
  }

  void reloadPage() {
    state.user.copyWith(
      bloodType: '-',
    );
    removeImage();
  }

  void updateUserAdmin(String usuario) {
    final user = state.user.copyWith(username: usuario);
    if (!isClosed) {
      emit(state.copyWith(user: user));
    }
  }

  void updateASO(DateTime ASO) {
    final user = state.user.copyWith(aso: ASO);
    emit(state.copyWith(user: user));
    checkCadastroHabilitado();
  }

  void updateNR34(DateTime NR34) {
    final user = state.user.copyWith(nr34: NR34);
    emit(state.copyWith(user: user));
    checkCadastroHabilitado();
  }

  void updateNR10(DateTime NR10) {
    final user = state.user.copyWith(nr10: NR10);
    emit(state.copyWith(user: user));
  }

  void updateNR33(DateTime NR33) {
    final user = state.user.copyWith(nr33: NR33);
    emit(state.copyWith(user: user));
  }

  void updateNR35(DateTime NR35) {
    final user = state.user.copyWith(nr35: NR35);
    emit(state.copyWith(user: user));
  }

  void updateDataInicial(DateTime dataInicial) {
    final user = state.user.copyWith(startJob: dataInicial);
    if (!isClosed) {
      emit(state.copyWith(user: user));
      checkCadastroHabilitado();
    }
  }

  void updateDataLimite(DateTime dataLimite) {
    final user = state.user.copyWith(endJob: dataLimite);
    checkCadastroHabilitado();
    if (!isClosed) {
      emit(state.copyWith(user: user));
      checkCadastroHabilitado();
    }
  }

  void updateIsVisitante(bool isVisitante) {
    final user = state.user.copyWith(isVisitor: isVisitante);
    if (!isClosed) {
      emit(state.copyWith(user: user));
      checkCadastroHabilitado();
    }
  }

  void updateIsAdmin(bool isAdmin) {
    final user = state.user.copyWith(isAdmin: isAdmin);
    if (!isClosed) {}
    emit(state.copyWith(user: user));
  }

  void updateEventos(List<String> eventos) {
    final user = state.user.copyWith(events: eventos);
    if (!isClosed) {}
    emit(state.copyWith(user: user));
  }

  void updateCreatedAt(DateTime createdAt) {
    final user = state.user.copyWith(createdAt: createdAt);
    if (!isClosed) {}
    emit(state.copyWith(user: user));
  }

  void updateUpdatedAt(DateTime updatedAt) {
    final user = state.user.copyWith(updatedAt: updatedAt);
    if (!isClosed) {
      if (!isClosed) {}
      emit(state.copyWith(user: user));
    }
  }

  void updateIsBlocked(bool isBlocked) {
    final user = state.user.copyWith(isBlocked: isBlocked);
    if (!isClosed) {
      if (!isClosed) {}
      emit(state.copyWith(user: user));
    }
  }

  void updateArea(String area) {
    final user = state.user.copyWith(area: area);
    if (!isClosed) {
      if (!isClosed) {}
      emit(state.copyWith(user: user));
      checkCadastroHabilitado();
    }
  }

  void createEvent() async {
    String vesselId = await localStorageService.getVesselId() ?? '';

    if (!isClosed) {
      emit(state.copyWith(
          isLoading: true,
          evento: state.evento.copyWith(
            id: const Uuid().v1().toString(),
            timestamp: DateTime.now(),
            action: 0,
            vesselId: vesselId,
            portalId: '0',
            userId: state.user.id,
            justification: "-",
            beaconId: state.user.iTag,
            status: 'created',
          )));
    }
    try {
      // await eventRepository.createEvent(state.evento);
      if (!isClosed) {
        if (!isClosed) {}
        emit(state.copyWith(isLoading: false, userCreated: true));
      }
    } catch (e) {
      SimpleLogger.warning('Error during cadastrar_cubit createEvent: $e');
      if (!isClosed) {
        if (!isClosed) {}
        emit(state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  Future<void> createUser() async {
    if (!isClosed) {}
    final user = state.user.copyWith(id: Uuid().v1());
    emit(state.copyWith(user: user));
    try {
      await userRepository.createUser(state.user);
      createEvent();
    } catch (e) {
      SimpleLogger.warning('Error cadastrar_cubit createUser: $e');
      if (!isClosed) {
        if (!isClosed) {}
        emit(state.copyWith(
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void checkCadastroHabilitado() {
    if (state.user.isVisitor) {
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
    return state.user.iTag.isNotEmpty &&
        state.user.name.isNotEmpty &&
        state.user.role.isNotEmpty &&
        state.user.company.isNotEmpty &&
        state.user.area.isNotEmpty &&
        state.user.picture.isNotEmpty &&
        state.user.endJob.isAfter(state.user.startJob);
  }

  bool visitorChecksPassed() {
    return state.user.blockReason.isNotEmpty &&
        state.user.name.isNotEmpty &&
        state.user.role.isNotEmpty &&
        state.user.company.isNotEmpty &&
        state.user.iTag.isNotEmpty &&
        state.user.picture.isNotEmpty;
  }

  @override
  Future<void> close() {
    if (isStreaming) {
      scanSubscription.cancel();
    }
    return super.close();
  }
}
