import 'package:dockcheck_web/models/employee.dart';
import 'package:dockcheck_web/repositories/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/simple_logger.dart';
import 'pesquisar_state.dart';

class PesquisarCubit extends Cubit<PesquisarState> {
  final EmployeeRepository employeeRepository;
  List<Employee> allEmployee = [];
  List<Employee> filteredEmployee = [];
  bool isSearching = false;
  String searchQuery = '';

  @override
  bool isClosed = false;

  PesquisarCubit(this.employeeRepository) : super(PesquisarInitial());

  Future<void> fetchEmployees() async {
    try {
      if (!isClosed) {
        emit(PesquisarLoading());
      }

      allEmployee = await employeeRepository.getAllEmployees();

      if (allEmployee.isNotEmpty) {
        //order by name
        allEmployee.sort((a, b) => a.name.compareTo(b.name));
      }

      if (!isClosed) {
        if (isSearching) {
          _applySearchFilter();
        } else {
          emit(PesquisarLoaded(allEmployee));
        }
      }
    } catch (e) {
      SimpleLogger.warning('Error during data synchronization: $e');
      if (!isClosed) {
        emit(PesquisarError("Failed to fetch users1. $e"));
      }
    }
  }

  Future<void> searchEmployee(String query) async {
    try {
      if (!isClosed) {
        emit(PesquisarLoading());
      }

      searchQuery = query;
      isSearching = true;

      // Verifica se já carregou os usuários do banco de dados
      if (allEmployee.isEmpty) {
        allEmployee = await employeeRepository.getAllEmployees();
      }

      filteredEmployee = allEmployee
          .where((employee) =>
              employee.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (!isClosed) {
        emit(PesquisarLoaded(filteredEmployee));
      }
    } catch (e) {
      SimpleLogger.warning('Error during data synchronization: $e');
      if (!isClosed) {
        emit(PesquisarError("Failed to fetch users2. $e"));
      }
    }
  }

  void _applySearchFilter() {
    filteredEmployee = allEmployee
        .where((employee) =>
            employee.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    emit(PesquisarLoaded(filteredEmployee));
  }

  @override
  Future<void> close() async {
    if (!isClosed) {
      isClosed = true;
      await super.close();
    }
  }
}
