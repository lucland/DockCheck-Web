import 'package:dockcheck_web/features/home/bloc/pesquisar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';
import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../widgets/cadastrar_modal_widget.dart';
import '../details/details.dart';
import '../home/bloc/pesquisar_state.dart';

class Projects extends StatelessWidget {
  const Projects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<PesquisarCubit>().fetchUsers();

    return BlocBuilder<PesquisarCubit, PesquisarState>(
      builder: (context, state) {
        if (state is PesquisarLoading) {
          return SizedBox(
              width: MediaQuery.of(context).size.width - 300,
              child: const Center(
                child: CircularProgressIndicator(),
              ));
        } else if (state is PesquisarError) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 300,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PesquisarLoaded) {
          List<User> displayedUsers = state.users;

          if (context.read<PesquisarCubit>().isSearching) {
            displayedUsers = displayedUsers
                .where((user) => user.name.toLowerCase().contains(
                    context.read<PesquisarCubit>().searchQuery.toLowerCase()))
                .toList();
          }

          return Container(
            color: DockColors.background,
            width: MediaQuery.of(context).size.width - 300,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Projetos',
                        style: DockTheme.h1.copyWith(
                          color: DockColors.iron100,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //open modal with a text
                          openModal(context, 'Adicionar funcionário');
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            color: DockColors.success120,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: DockColors.success120,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: DockColors.white,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Criar projeto',
                                  style: DockTheme.h2.copyWith(
                                      color: DockColors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListView.builder(
                        itemCount: displayedUsers.length,
                        itemBuilder: (context, index) {
                          User user = displayedUsers[index];
                          return _buildProjectListTile(context, user);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }

  Widget _buildProjectListTile(BuildContext context, User user) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: InkWell(
          onTap: () {
            _openRightSideModal(context, user);
          },
          child: Card(
            color: DockColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Image.asset(
                        'assets/svg/skandi_iguacu.jpeg',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Skandi Salvador',
                          style: DockTheme.h1.copyWith(
                            color: DockColors.iron100,
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                          ),
                        ),
                        Text(
                          'DOCAGEM',
                          style: DockTheme.h2.copyWith(
                            color: DockColors.slate110,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          child: Divider(
                            color: DockColors.slate100.withAlpha(100),
                            thickness: 2,
                          ),
                        ),
                        Text(
                          '18/04/24 - 30/05/24',
                          style: DockTheme.h2.copyWith(
                            color: DockColors.success100,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '35 empresas convidadas',
                          style: DockTheme.h2.copyWith(
                            color: DockColors.iron100,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '20 empresas participantes',
                          style: DockTheme.h2.copyWith(
                            color: DockColors.iron100,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: DockColors.iron100,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _openRightSideModal(BuildContext context, User user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 1,
          child: SizedBox(
            width: MediaQuery.of(context).size.width *
                0.5, // 50% width of the screen
            child: Details(
                user:
                    user), // Assuming Details widget takes a user as a parameter
          ),
        );
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Makes background transparent
    );
  }

  void openModal(BuildContext context, String s) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CadastrarModal(
          s: s,
        );
      },
    );
  }
}
