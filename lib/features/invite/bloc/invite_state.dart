import '../../../models/invite.dart';

class InviteState {
  final List<Invite> invites;
  final bool isLoading;
  final String? error;
  final bool isEmailValid;
  final bool isInputEnabled;

  InviteState(
      {this.invites = const [],
      this.isLoading = false,
      this.error,
      this.isEmailValid = true,
      this.isInputEnabled = true});

  InviteState copyWith(
      {List<Invite>? invites,
      bool? isLoading,
      String? error,
      bool? isEmailValid,
      bool? isInputEnabled}) {
    return InviteState(
      invites: invites ?? this.invites,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isInputEnabled: isInputEnabled ?? this.isInputEnabled,
    );
  }
}
