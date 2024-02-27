import 'package:dockcheck_web/features/home/bloc/pesquisar_cubit.dart';
import 'package:dockcheck_web/features/home/home.dart';
import 'package:dockcheck_web/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'features/details/bloc/details_cubit.dart';
import 'features/home/bloc/cadastrar_cubit.dart';
import 'features/login/bloc/login_cubit.dart';
import 'repositories/area_repository.dart';
import 'repositories/authorization_repository.dart';
import 'repositories/beacon_repository.dart';
import 'repositories/company_repository.dart';
import 'repositories/document_repository.dart';
import 'repositories/employee_repository.dart';
import 'repositories/event_repository.dart';
import 'repositories/invite_repository.dart';
import 'repositories/login_repository.dart';
import 'repositories/picture_repository.dart';
import 'repositories/third_company_repository.dart';
import 'repositories/third_project_repository.dart';
import 'repositories/user_repository.dart';
import 'repositories/vessel_repository.dart';
import 'services/api_service.dart';
import 'services/local_storage_service.dart';

void main() {
  var localStorageService = LocalStorageService();
  localStorageService.init();
  var apiService = ApiService(localStorageService);

  var loginRepository = LoginRepository(apiService);
  var authorizationRepository = AuthorizationRepository(apiService);
  var companyRepository = CompanyRepository(apiService);
  var eventRepository = EventRepository(apiService, localStorageService);
  var userRepository = UserRepository(apiService, localStorageService);
  var vesselRepository = VesselRepository(apiService);
  var beaconRepository = BeaconRepository(apiService);
  var areaRepository = AreaRepository(apiService);
  var documentRepository = DocumentRepository(apiService);
  var employeeRepository = EmployeeRepository(apiService);
  var inviteRepository = InviteRepository(apiService);
  var pictureRepository = PictureRepository(apiService);
  var thirdCompanyRepository = ThirdCompanyRepository(apiService);
  var thirdProjectRepository = ThirdProjectRepository(apiService);

  var loginCubit =
      LoginCubit(loginRepository, userRepository, localStorageService);
  var pesquisarCUbit = PesquisarCubit(employeeRepository);
  var cadastrarCubit = CadastrarCubit(employeeRepository, localStorageService,
      eventRepository, pictureRepository, documentRepository);
  var detailsCubit =
      DetailsCubit(employeeRepository, documentRepository, localStorageService);

  runApp(
    MultiBlocProvider(
      providers: [
        Provider<LoginRepository>(create: (_) => loginRepository),
        Provider<AuthorizationRepository>(
            create: (_) => authorizationRepository),
        Provider<CompanyRepository>(create: (_) => companyRepository),
        Provider<EventRepository>(create: (_) => eventRepository),
        Provider<UserRepository>(create: (_) => userRepository),
        Provider<VesselRepository>(create: (_) => vesselRepository),
        Provider<ApiService>(create: (_) => apiService),
        Provider<LocalStorageService>(create: (_) => localStorageService),
        BlocProvider<LoginCubit>(create: (_) => loginCubit),
        Provider<BeaconRepository>(create: (_) => beaconRepository),
        Provider<AreaRepository>(create: (_) => areaRepository),
        Provider<DocumentRepository>(create: (_) => documentRepository),
        Provider<EmployeeRepository>(create: (_) => employeeRepository),
        Provider<InviteRepository>(create: (_) => inviteRepository),
        Provider<PictureRepository>(create: (_) => pictureRepository),
        Provider<ThirdCompanyRepository>(create: (_) => thirdCompanyRepository),
        Provider<ThirdProjectRepository>(create: (_) => thirdProjectRepository),
        BlocProvider<PesquisarCubit>(create: (_) => pesquisarCUbit),
        BlocProvider<CadastrarCubit>(create: (_) => cadastrarCubit),
        BlocProvider<DetailsCubit>(create: (_) => detailsCubit),
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
      //home: Login(),
      home: const Home(),
    );
  }
}
