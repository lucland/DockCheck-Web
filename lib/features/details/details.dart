import 'package:dockcheck_web/features/details/bloc/details_cubit.dart';
import 'package:dockcheck_web/utils/colors.dart';
import 'package:dockcheck_web/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user.dart';
import '../../utils/formatter.dart';
import '../../utils/theme.dart';
import '../../widgets/title_value_widget.dart';

class Details extends StatelessWidget {
  final User user;

  const Details({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DockColors.white,
      child: DetailsView(
        user: user,
      ),
    );
  }
}

class DetailsView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final User user;

  DetailsView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    context.read<DetailsCubit>().getUser(user.id);
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        if (state is DetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is DetailsLoaded) {
          return Scaffold(
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            color: DockColors.iron100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(user.name,
                                      style: DockTheme.h1.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text('|   N° ${user.number.toString()}',
                                    style: DockTheme.h1
                                        .copyWith(color: Colors.white),
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          user.isOnboarded
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16),
                                  color: DockColors.success20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.check_circle_rounded,
                                        color: DockColors.success120,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                          'Usuário com documentos em dia e atrelado a um projeto',
                                          style: DockTheme.h1.copyWith(
                                              color: DockColors.success120,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16),
                                  color: Color.fromARGB(255, 240, 228, 228),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.cancel,
                                        color: DockColors.danger110,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text('Usuário bloqueado por pendências',
                                          style: DockTheme.h1.copyWith(
                                              color: DockColors.danger110,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleValueWidget(
                                  title: DockStrings.cpf,
                                  value: user.cpf,
                                  color: DockColors.iron100,
                                ),
                                TitleValueWidget(
                                  title: DockStrings.blood,
                                  value: user.bloodType, // tipo sanguineo
                                  color: DockColors.iron100,
                                ),
                                TitleValueWidget(
                                  title: DockStrings.funcao,
                                  value: user.role,
                                  color: DockColors.iron100,
                                ),
                                if (user.email != '') ...[
                                  TitleValueWidget(
                                    title: DockStrings.email,
                                    value: user.email,
                                    color: DockColors.iron100,
                                  ),
                                ],
                                TitleValueWidget(
                                  title: DockStrings.area,
                                  value: user.area,
                                  color: DockColors.iron100,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: DockColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DockStrings.validades,
                                      style: DockTheme.h1.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                      child: Divider(
                                        color: DockColors.slate100,
                                        thickness: 0.3,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        TitleValueWidget(
                                          title: DockStrings.aso,
                                          value: Formatter.formatDateTime(
                                              user.aso),
                                          color: Formatter.formatDateTime(
                                                          user.aso)
                                                      .compareTo(Formatter
                                                          .formatDateTime(
                                                              DateTime.now())) <
                                                  0
                                              ? DockColors.danger100
                                              : DockColors.iron100,
                                        ),
                                        if (Formatter.formatDateTime(user.aso)
                                                .compareTo(
                                                    Formatter.formatDateTime(
                                                        DateTime.now())) <
                                            0)
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: 4,
                                                height: 16,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 265.0),
                                                child: Text(
                                                  ' Aso expirado',
                                                  style: TextStyle(
                                                    color: DockColors.danger100,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TitleValueWidget(
                                          title: DockStrings.nr34,
                                          value: Formatter.formatDateTime(
                                              user.nr34),
                                          color: Formatter.formatDateTime(
                                                          user.nr34)
                                                      .compareTo(Formatter
                                                          .formatDateTime(
                                                              DateTime.now())) <
                                                  0
                                              ? DockColors.danger100
                                              : DockColors.iron100,
                                        ),
                                        if (Formatter.formatDateTime(user.nr34)
                                                .compareTo(
                                                    Formatter.formatDateTime(
                                                        DateTime.now())) <
                                            0)
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ' NR34 expirado',
                                                    style: TextStyle(
                                                      color:
                                                          DockColors.danger100,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        TitleValueWidget(
                                          title: DockStrings.nr10,
                                          value: Formatter.formatDateTime(
                                              user.nr10),
                                          color: Formatter.formatDateTime(
                                                          user.nr10)
                                                      .compareTo(Formatter
                                                          .formatDateTime(
                                                              DateTime.now())) <
                                                  0
                                              ? DockColors.danger100
                                              : DockColors.iron100,
                                        ),
                                        if (Formatter.formatDateTime(user.nr10)
                                                .compareTo(
                                                    Formatter.formatDateTime(
                                                        DateTime.now())) <
                                            0)
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ' NR10 expirado',
                                                    style: TextStyle(
                                                      color:
                                                          DockColors.danger100,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TitleValueWidget(
                                          title: DockStrings.nr33,
                                          value: Formatter.formatDateTime(
                                              user.nr33),
                                          color: Formatter.formatDateTime(
                                                          user.nr33)
                                                      .compareTo(Formatter
                                                          .formatDateTime(
                                                              DateTime.now())) <
                                                  0
                                              ? DockColors.danger100
                                              : DockColors.iron100,
                                        ),
                                        if (Formatter.formatDateTime(user.nr33)
                                                .compareTo(
                                                    Formatter.formatDateTime(
                                                        DateTime.now())) <
                                            0)
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ' NR33 expirado',
                                                    style: TextStyle(
                                                      color:
                                                          DockColors.danger100,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        TitleValueWidget(
                                          title: DockStrings.nr35,
                                          value: Formatter.formatDateTime(
                                              user.nr35),
                                          color: Formatter.formatDateTime(
                                                          user.nr35)
                                                      .compareTo(Formatter
                                                          .formatDateTime(
                                                              DateTime.now())) <
                                                  0
                                              ? DockColors.danger100
                                              : DockColors.iron100,
                                        ),
                                        if (Formatter.formatDateTime(user.nr35)
                                                .compareTo(
                                                    Formatter.formatDateTime(
                                                        DateTime.now())) <
                                            0)
                                          Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ' NR35 expirado',
                                                  style: TextStyle(
                                                    color: DockColors.danger100,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: DockColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DockStrings.estadia,
                                          style: DockTheme.h1.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Divider(
                                            color: DockColors.iron100,
                                            thickness: 0.3,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              DockStrings.de,
                                              style: DockTheme.body.copyWith(
                                                color: DockColors.iron100,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              Formatter.formatDateTime(
                                                  user.startJob),
                                              style: DockTheme.body.copyWith(
                                                color: DockColors.iron100,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              DockStrings.ate,
                                              style: DockTheme.body.copyWith(
                                                color: DockColors.iron100,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  Formatter.formatDateTime(
                                                      user.endJob),
                                                  style:
                                                      DockTheme.body.copyWith(
                                                    color: Formatter.formatDateTime(
                                                                    user.endJob)
                                                                .compareTo(Formatter
                                                                    .formatDateTime(
                                                                        DateTime
                                                                            .now())) <
                                                            0
                                                        ? DockColors.danger100
                                                        : DockColors.iron100,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            //Navigator.pushNamed(context, '/remove', arguments: user);
                            //open dialog asking if the user is sure to remove the user
                            _openRemoveDialog(context);
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: DockColors.danger100,
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Remover',
                                  style: DockTheme.body.copyWith(
                                    color: DockColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, '/edit', arguments: user);
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: DockColors.iron100,
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Editar',
                                  style: DockTheme.body.copyWith(
                                    color: DockColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //danger100 button to remove user
                    ],
                  ),
                ]),
          );
        } else {
          return const Center(child: Text('Erro desconhecido'));
        }
      },
    );
  }

  void _openRemoveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: DockColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          title: const Text(
            'Remover usuário',
            style: TextStyle(
                color: DockColors.iron100, fontWeight: FontWeight.w600),
          ),
          content: const Text('Tem certeza que deseja remover o usuário?',
              style: TextStyle(color: DockColors.iron100)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // context.read<DetailsCubit>().removeUser(user.id);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Remover',
                style: TextStyle(
                    color: DockColors.danger100, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
