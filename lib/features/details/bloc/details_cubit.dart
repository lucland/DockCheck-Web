import 'package:dockcheck_web/models/employee.dart';
import 'package:dockcheck_web/repositories/document_repository.dart';
import 'package:dockcheck_web/repositories/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/document.dart';
import '../../../services/local_storage_service.dart';
import '../../../utils/simple_logger.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final EmployeeRepository employeeRepository;
  final DocumentRepository documentsRepository; // Added DocumentsRepository
  final LocalStorageService localStorageService;

  DetailsCubit(this.employeeRepository, this.documentsRepository,
      this.localStorageService)
      : super(DetailsInitial());

  Future<void> getEmployeeAndDocuments(String employeeId) async {
    try {
      emit(DetailsLoading());
      final employee = await employeeRepository.getEmployeeById(employeeId);
      /*final documentIds =
          await documentsRepository.getDocumentIdsByEmployeeId(employeeId);
      final documents = await Future.wait<Document>(
          documentIds.map((id) => documentsRepository.getDocumentById(id)));
      List<Document> filteredDocuments = documents
          .where((document) => document.type.isNotEmpty)
          .toList()
          .cast<Document>();*/
      emit(DetailsLoaded(employee, []));
    } catch (e) {
      SimpleLogger.warning('Error fetching user or documents: $e');
      emit(DetailsError('Failed to fetch user or documents: $e'));
    }
  }
}
