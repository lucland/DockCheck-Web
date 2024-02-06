import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import '../../../repositories/user_repository.dart';
import '../../../services/local_storage_service.dart';
import '../../../utils/simple_logger.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final UserRepository userRepository;
  final LocalStorageService localStorageService;

  DetailsCubit(this.userRepository, this.localStorageService)
      : super(DetailsInitial());

  Future<void> getUser(String userId) async {
    try {
      emit(DetailsLoading());
      final user = await userRepository.getUser(userId);
      emit(DetailsLoaded(user));
    } catch (e) {
      SimpleLogger.warning('Error fetching user: $e');
      emit(DetailsError('Failed to fetch user: $e'));
    }
  }
}
