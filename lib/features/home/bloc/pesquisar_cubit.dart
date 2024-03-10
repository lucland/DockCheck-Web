import 'package:dockcheck_web/models/employee.dart';
import 'package:dockcheck_web/models/project.dart';
import 'package:dockcheck_web/repositories/employee_repository.dart';
import 'package:dockcheck_web/repositories/project_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/simple_logger.dart';
import 'pesquisar_state.dart';

class PesquisarCubit extends Cubit<PesquisarState> {
  final EmployeeRepository employeeRepository;
  final ProjectRepository projectRepository;
  List<Employee> allEmployee = [];
  List<Project> allProjects = [];
  List<Employee> filteredEmployee = [];
  bool isSearching = false;
  String searchQuery = '';

  @override
  bool isClosed = false;

  PesquisarCubit(this.employeeRepository, this.projectRepository)
      : super(PesquisarInitial());

  Future<void> fetchEmployees() async {
    print("fetchEmployees");
    SimpleLogger.info('Fetching employees');
    try {
      if (!isClosed) {
        emit(PesquisarLoading());
      }

      allProjects = await projectRepository.getAllProjects();

      allEmployee = await employeeRepository.getAllEmployees();
      print(allEmployee.length);

      if (!isClosed) {
        emit(PesquisarLoaded(allEmployee, allProjects));
      }
    } catch (e) {
      SimpleLogger.warning('Error during data synchronization: $e');
      if (!isClosed) {
        emit(PesquisarError("Failed to fetch users1. $e"));
      }
    }
  }

  //fetchProjects
  Future<void> fetchProjects() async {
    SimpleLogger.info('Fetching projects');
    try {
      if (!isClosed) {
        emit(PesquisarLoading());
      }

      allProjects = await projectRepository.getAllProjects();

      if (!isClosed) {
        if (isSearching) {
          _applySearchFilter();
        } else {
          emit(PesquisarLoaded(allEmployee, allProjects));
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
        emit(PesquisarLoaded(filteredEmployee, allProjects));
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

    emit(PesquisarLoaded(filteredEmployee, allProjects));
  }

  @override
  Future<void> close() async {
    if (!isClosed) {
      isClosed = true;
      await super.close();
    }
  }
}
