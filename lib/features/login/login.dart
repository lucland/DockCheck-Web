import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/colors.dart';
import '../../utils/strings.dart';
import '../../utils/theme.dart';
import '../../widgets/text_input_widget.dart';
import '../home/home.dart';
import 'bloc/login_cubit.dart';
import 'bloc/login_state.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DockColors.background,
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            } else if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Erro ao fazer login'),
                  backgroundColor: DockColors.danger100,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  color: DockColors.iron100,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Image.asset('assets/svg/logo_dock_check.png'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: DockColors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          width: 700,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextInputWidget(
                                    title: 'Usuário',
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _usernameController,
                                  ),
                                  TextInputWidget(
                                    title: 'Senha',
                                    keyboardType: TextInputType.text,
                                    controller: _passwordController,
                                    isPassword: true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: InkWell(
                                      onTap: () {
                                        BlocProvider.of<LoginCubit>(context)
                                            .logIn(
                                          _usernameController.text,
                                          _passwordController.text,
                                        );
                                      },
                                      child: Container(
                                        width: 784,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: DockColors.iron100,
                                        ),
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          DockStrings.login,
                                          overflow: TextOverflow.ellipsis,
                                          style: DockTheme.headLine.copyWith(
                                              color: DockColors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
