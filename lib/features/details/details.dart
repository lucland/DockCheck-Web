import 'package:dockcheck_web/features/details/bloc/details_cubit.dart';
import 'package:dockcheck_web/models/employee.dart';
import 'package:dockcheck_web/utils/colors.dart';
import 'package:dockcheck_web/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/document.dart';
import '../../utils/formatter.dart';
import '../../utils/theme.dart';
import '../../widgets/title_value_widget.dart';

class Details extends StatelessWidget {
  final Employee employee;

  const Details({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DockColors.white,
      child: DetailsView(
        employee: employee,
      ),
    );
  }
}

class DetailsView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final Employee employee;

  DetailsView({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    context.read<DetailsCubit>().getEmployeeAndDocuments(employee.id);
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        if (state is DetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is DetailsLoaded) {
          final documents = state.documents;

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
                                  child: Text(employee.name,
                                      style: DockTheme.h1.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text('|   N° ${employee.number.toString()}',
                                    style: DockTheme.h1
                                        .copyWith(color: Colors.white),
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          employee.documentsOk
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
                                      Text('Usuário com documentos em dia',
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
                                  color:
                                      const Color.fromARGB(255, 240, 228, 228),
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
                                  value: employee.cpf,
                                  color: DockColors.iron100,
                                ),
                                TitleValueWidget(
                                  title: DockStrings.blood,
                                  value: employee.bloodType, // tipo sanguineo
                                  color: DockColors.iron100,
                                ),
                                TitleValueWidget(
                                  title: DockStrings.funcao,
                                  value: employee.role,
                                  color: DockColors.iron100,
                                ),
                                if (employee.email != '') ...[
                                  TitleValueWidget(
                                    title: DockStrings.email,
                                    value: employee.email,
                                    color: DockColors.iron100,
                                  ),
                                ],
                                TitleValueWidget(
                                  title: DockStrings.area,
                                  value: employee.area,
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
                                    ListView.builder(
                                      itemCount: documents.length,
                                      itemBuilder: (context, index) {
                                        Document document = documents[index];
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TitleValueWidget(
                                                  title: document.type,
                                                  value:
                                                      Formatter.formatDateTime(
                                                          document
                                                              .expirationDate),
                                                  color: document.expirationDate
                                                          .isBefore(
                                                              DateTime.now())
                                                      ? DockColors.danger100
                                                      : DockColors.iron100,
                                                ),
                                                if (document.expirationDate
                                                    .isBefore(DateTime.now()))
                                                  Text(
                                                    ' ${document.type} expirado',
                                                    style: const TextStyle(
                                                      color:
                                                          DockColors.danger100,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        );
                                      },
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
