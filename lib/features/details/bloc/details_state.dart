part of 'details_cubit.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final User user;
  DetailsLoaded(this.user);
}

class DetailsError extends DetailsState {
  final String message;
  DetailsError(this.message);
}
