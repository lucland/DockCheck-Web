import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../models/invite.dart';
import '../../../repositories/invite_repository.dart';
import 'invite_state.dart';

class InviteCubit extends Cubit<InviteState> {
  final InviteRepository inviteRepository;

  InviteCubit(this.inviteRepository) : super(InviteState());

  void sendInvite(String email, String companyName) async {
    emit(state.copyWith(isLoading: true, isInputEnabled: false));
    if (!_validateEmail(email)) {
      emit(state.copyWith(
          isEmailValid: false, isLoading: false, isInputEnabled: true));
      return;
    }
    Invite invite = Invite(
      id: Uuid().v4(),
      email: email,
      accepted: false,
      sent: true,
      thirdCompanyName: companyName,
      dateSent: DateTime.now(),
      viewed: false,
    );
    final result = await inviteRepository.createInvite(invite);
    if (result != null) {
      emit(state.copyWith(isLoading: false, isInputEnabled: true));
      getAllInvites();
    } else {
      emit(
          state.copyWith(error: 'Falha ao enviar o convite', isLoading: false));
    }
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  void validateEmail(String email) {
    emit(state.copyWith(isEmailValid: _validateEmail(email)));
  }

  void getAllInvites() async {
    if (state.isLoading == false) {
      (state.copyWith(isLoading: true));
    }
    final invites = await inviteRepository.getAllInvites();
    //reorder the invites to show the most recent first
    invites.sort((a, b) => b.dateSent.compareTo(a.dateSent));

    emit(state.copyWith(
        invites: invites, isLoading: false, isInputEnabled: true));
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
    sendInvite(email, companyName);
  }
}
