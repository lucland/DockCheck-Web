import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../models/invite.dart';
import '../../../repositories/invite_repository.dart';
import 'invite_state.dart';

class InviteCubit extends Cubit<InviteState> {
  final InviteRepository inviteRepository;

  InviteCubit(this.inviteRepository) : super(InviteState());

  void sendInvite(String email, String companyName) async {
    if (!_validateEmail(email)) {
      emit(state.copyWith(isEmailValid: false));
      return;
    }
    emit(state.copyWith(
        isLoading: true, isEmailValid: true, isInputEnabled: false));
    /*final newInvite = Invite(
      id: const Uuid().v4(),
      email: email,
      accepted: false,
      sent: true,
      thirdCompanyName: companyName,
      dateSent: DateTime.now(),
      viewed: false,
    );

    final result = await inviteRepository.createInvite(newInvite);
    if (result.id.isNotEmpty) {
      getAllInvites();
    } else {
      emit(
          state.copyWith(error: 'Falha ao enviar o convite', isLoading: false, isInputEnabled: true));
    }*/
    //wait 2 seconds to simulate the API call
    await Future.delayed(const Duration(seconds: 3));
    getAllInvites();
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  void validateEmail(String email) {
    emit(state.copyWith(isEmailValid: _validateEmail(email)));
  }

  void getAllInvites() async {
    emit(state.copyWith(isLoading: true));
    /*  final invites = await inviteRepository.getAllInvites();
    //if invites is empty, return a list with mock data
    if (invites.isEmpty) {*/
    emit(state.copyWith(
      invites: [
        Invite(
            id: '1',
            email: 'mock1@email.com',
            accepted: false,
            sent: true,
            thirdCompanyName: 'mockCompany 1',
            dateSent: DateTime.now(),
            viewed: false),
        Invite(
            id: '2',
            email: 'mock2@email.com',
            accepted: false,
            sent: true,
            thirdCompanyName: 'mockCompany 2',
            dateSent: DateTime.now(),
            viewed: false),
        Invite(
            id: '3',
            email: 'mock3@email.com',
            accepted: true,
            sent: true,
            thirdCompanyName: 'mockCompany 3',
            dateSent: DateTime.now(),
            viewed: true),
      ],
      isLoading: false,
      isInputEnabled: true,
    ));
    /*
    } else {
      emit(state.copyWith(
          invites: invites, isLoading: false, isInputEnabled: true));
    }*/
  }

  void cancelInvite(String inviteId) async {
    emit(state.copyWith(isLoading: true));
    final result = await inviteRepository.cancelInvite(inviteId);
    if (result) {
      getAllInvites();
    } else {
      emit(state.copyWith(
          error: 'Falha ao cancelar o convite', isLoading: false));
    }
  }

  void resendInvite(String email, String companyName) async {
    emit(state.copyWith(isLoading: true));
    sendInvite(email, companyName);
  }
}
