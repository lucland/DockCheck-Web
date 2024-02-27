part of 'details_cubit.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final Employee employee;
  final List<Document> documents;
  DetailsLoaded(this.employee, this.documents);
}

class DetailsError extends DetailsState {
  final String message;
  DetailsError(this.message);
}
