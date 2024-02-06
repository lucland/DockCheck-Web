import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import '../../../repositories/user_repository.dart';
import '../../../utils/simple_logger.dart';
import 'pesquisar_state.dart';

class PesquisarCubit extends Cubit<PesquisarState> {
  final UserRepository userRepository;
  List<User> allUsers = [];
  List<User> filteredUsers = [];
  bool isSearching = false;
  String searchQuery = '';

  @override
  bool isClosed = false;

  PesquisarCubit(this.userRepository) : super(PesquisarInitial());

  Future<void> fetchUsers() async {
    try {
      if (!isClosed) {
        emit(PesquisarLoading());
      }

      allUsers = await userRepository.getAllUsers();

      if (allUsers.length > 0) {
        //order by name
        allUsers.sort((a, b) => a.name.compareTo(b.name));
      }

      if (!isClosed) {
        if (isSearching) {
          _applySearchFilter();
        } else {
          emit(PesquisarLoaded(allUsers));
        }
      }
    } catch (e) {
      SimpleLogger.warning('Error during data synchronization: $e');
      if (!isClosed) {
        emit(PesquisarError("Failed to fetch users1. $e"));
      }
    }
  }

  Future<void> searchUsers(String query) async {
    try {
      if (!isClosed) {
        emit(PesquisarLoading());
      }

      searchQuery = query;
      isSearching = true;

      // Verifica se já carregou os usuários do banco de dados
      if (allUsers.isEmpty) {
        allUsers = await userRepository.getAllUsers();
      }

      filteredUsers = allUsers
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (!isClosed) {
        emit(PesquisarLoaded(filteredUsers));
      }
    } catch (e) {
      SimpleLogger.warning('Error during data synchronization: $e');
      if (!isClosed) {
        emit(PesquisarError("Failed to fetch users2. $e"));
      }
    }
  }

  void _applySearchFilter() {
    filteredUsers = allUsers
        .where((user) =>
            user.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    emit(PesquisarLoaded(filteredUsers));
  }

  @override
  Future<void> close() async {
    if (!isClosed) {
      isClosed = true;
      await super.close();
    }
  }
}
