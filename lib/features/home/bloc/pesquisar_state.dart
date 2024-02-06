import '../../../models/user.dart';

abstract class PesquisarState {}

class PesquisarInitial extends PesquisarState {}

class PesquisarLoading extends PesquisarState {}

class PesquisarLoaded extends PesquisarState {
  final List<User> users;
  PesquisarLoaded(this.users);
}

class PesquisarError extends PesquisarState {
  final String message;
  PesquisarError(this.message);
}
