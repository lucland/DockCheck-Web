import 'package:dockcheck_web/features/home/bloc/pesquisar_cubit.dart';
import 'package:dockcheck_web/features/home/home.dart';
import 'package:dockcheck_web/features/login/login.dart';
import 'package:dockcheck_web/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'features/login/bloc/login_cubit.dart';
import 'repositories/authorization_repository.dart';
import 'repositories/beacon_repository.dart';
import 'repositories/company_repository.dart';
import 'repositories/docking_repository.dart';
import 'repositories/event_repository.dart';
import 'repositories/login_repository.dart';
import 'repositories/portal_repository.dart';
import 'repositories/receptor_repository.dart';
import 'repositories/supervisor_repository.dart';
import 'repositories/user_repository.dart';
import 'repositories/vessel_repository.dart';
import 'services/api_service.dart';
import 'services/local_storage_service.dart';

void main() {
  var localStorageService = LocalStorageService();
  localStorageService.init();
  var apiService = ApiService(localStorageService);

  var loginRepository = LoginRepository(apiService);
  var authorizationRepository =
      AuthorizationRepository(apiService, localStorageService);
  var companyRepository = CompanyRepository(apiService, localStorageService);
  var dockingRepository = DockingRepository(apiService, localStorageService);
  var eventRepository = EventRepository(apiService, localStorageService);
  var portalRepository = PortalRepository(apiService, localStorageService);
  var supervisorRepository =
      SupervisorRepository(apiService, localStorageService);
  var userRepository = UserRepository(apiService, localStorageService);
  var vesselRepository = VesselRepository(apiService, localStorageService);
  var beaconRepository = BeaconRepository(apiService, localStorageService);
  var receptorRepository = ReceptorRepository(apiService, localStorageService);

  var loginCubit =
      LoginCubit(loginRepository, userRepository, localStorageService);
  var userCUbit = UserCubit(userRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        Provider<LoginRepository>(create: (_) => loginRepository),
        Provider<AuthorizationRepository>(
            create: (_) => authorizationRepository),
        Provider<CompanyRepository>(create: (_) => companyRepository),
        Provider<DockingRepository>(create: (_) => dockingRepository),
        Provider<EventRepository>(create: (_) => eventRepository),
        Provider<PortalRepository>(create: (_) => portalRepository),
        Provider<SupervisorRepository>(create: (_) => supervisorRepository),
        Provider<UserRepository>(create: (_) => userRepository),
        Provider<VesselRepository>(create: (_) => vesselRepository),
        Provider<ApiService>(create: (_) => apiService),
        Provider<LocalStorageService>(create: (_) => localStorageService),
        BlocProvider<LoginCubit>(create: (_) => loginCubit),
        Provider<BeaconRepository>(create: (_) => beaconRepository),
        Provider<ReceptorRepository>(create: (_) => receptorRepository),
        BlocProvider<UserCubit>(create: (_) => userCUbit),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DockTheme.theme,
      home: Login(),
    );
  }
}
