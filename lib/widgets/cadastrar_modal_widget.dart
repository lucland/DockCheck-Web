import 'package:dockcheck_web/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../enums/nrs_enum.dart';
import '../features/home/bloc/cadastrar_cubit.dart';
import '../features/home/bloc/cadastrar_state.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import '../utils/theme.dart';
import 'calendar_picker_widget.dart';
import 'text_input_widget.dart';

class CadastrarModal extends StatelessWidget {
  final String s;
  const CadastrarModal({
    super.key,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    String name = '';
    String email = '';
    String empresa = '';
    String funcao = '';
    String cpf = '';
    String bloodType = 'A+';

    return BlocBuilder<CadastrarCubit, CadastrarState>(
      builder: (context, state) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: DockColors.white,
          surfaceTintColor: DockColors.white,
          title: Text(s),
          content: SizedBox(
            width: 800,
            height: MediaQuery.of(context).size.height - 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextInputWidget(
                    title: DockStrings.nome,
                    isRequired: true,
                    controller: TextEditingController(
                      text: name,
                    ),
                    onChanged: (text) {
                      name = text;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextInputWidget(
                              isRequired: true,
                              title: DockStrings.email,
                              controller: TextEditingController(
                                text: email,
                              ),
                              onChanged: (text) {
                                email = text;
                              },
                            ),
                            TextInputWidget(
                              title: DockStrings.empresa,
                              controller: TextEditingController(
                                text: empresa,
                              ),
                              onChanged: (text) {
                                empresa = text;
                              },
                              isRequired: true,
                            ),
                            TextInputWidget(
                              title: DockStrings.funcao,
                              controller: TextEditingController(
                                text: funcao,
                              ),
                              onChanged: (text) {
                                funcao = text;
                              },
                              isRequired: true,
                            ),
                            TextInputWidget(
                              title: DockStrings.cpf,
                              controller: TextEditingController(
                                text: cpf,
                              ),
                              onChanged: (text) {
                                cpf = text;
                              },
                              keyboardType: TextInputType.number,
                              isRequired: true,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Tipo sanguíneo',
                                    style: DockTheme.h2),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, right: 16, bottom: 8),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 11.5),
                                      hintText: 'Tipo Sanguíneo',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: DockColors.slate100,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: DockColors.slate100,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    value: bloodType,
                                    onChanged: (String? newValue) {
                                      bloodType = newValue ?? 'A+';
                                    },
                                    items: [
                                      'A+',
                                      'A-',
                                      'B+',
                                      'B-',
                                      'AB+',
                                      'AB-',
                                      'O+',
                                      'O-',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text('Foto',
                                        style: DockTheme.h2,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Text(
                                      '*',
                                      style: DockTheme.h2.copyWith(
                                          color: DockColors.danger100),
                                    ),
                                  ),
                                ],
                              ),
                              ImagePickerWidget(
                                  cubit: context.read<CadastrarCubit>()),
                            ],
                          )),
                    ],
                  ),
                  //a collumn with a Text saying "Autorização de entrada" and below a row with three containers with a text and a logic to switch between them when clicked
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
                        child: Text(
                          'Autorização de entrada',
                          overflow: TextOverflow.ellipsis,
                          style: DockTheme.h1.copyWith(
                              color: DockColors.iron80,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<CadastrarCubit>()
                                    .updateAuthorizationType('Embarcação');
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: state.employee.area == 'Embarcação'
                                      ? DockColors.iron100
                                      : DockColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: DockColors.iron100,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Autorizado',
                                      style: TextStyle(
                                          color: state.employee.area ==
                                                  'Embarcação'
                                              ? DockColors.white
                                              : DockColors.iron100)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<CadastrarCubit>()
                                    .updateAuthorizationType('Dique seco');
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: state.employee.area == 'Dique seco'
                                      ? DockColors.iron100
                                      : DockColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: DockColors.iron100,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Dique seco',
                                      style: TextStyle(
                                          color: state.employee.area ==
                                                  'Dique seco'
                                              ? DockColors.white
                                              : DockColors.iron100)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<CadastrarCubit>()
                                    .updateAuthorizationType('Ambos');
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: state.employee.area == 'Ambos'
                                      ? DockColors.iron100
                                      : DockColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: DockColors.iron100,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Ambos',
                                      style: TextStyle(
                                          color: state.employee.area == 'Ambos'
                                              ? DockColors.white
                                              : DockColors.iron100)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
                        child: Text(
                          'Documentos',
                          overflow: TextOverflow.ellipsis,
                          style: DockTheme.h1.copyWith(
                              color: DockColors.iron80,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      CalendarPickerWidget(
                        showAttachmentIcon: true,
                        title: DockStrings.aso,
                        isRequired: true,
                        controller: TextEditingController(),
                        onChanged: (time) {},
                      ),
                      CalendarPickerWidget(
                        showAttachmentIcon: true,
                        title: DockStrings.nr34,
                        isRequired: true,
                        controller: TextEditingController(),
                        onChanged: (time) {},
                      ),
                      ...state.nrTypes.map(
                        (nrType) => CalendarPickerWidget(
                          showAttachmentIcon: true,
                          title: nrType,
                          isRequired: false,
                          controller: TextEditingController(),
                          onChanged: (time) {},
                          showRemoveButton: true,
                          onRemove: () => context
                              .read<CadastrarCubit>()
                              .removeNrType(nrType),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 11.5),
                                  hintText: 'Adicionar NR',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: DockColors.slate100,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: DockColors.slate100,
                                      width: 1,
                                    ),
                                  ),
                                  focusColor: DockColors.background,
                                  hoverColor: DockColors.background,
                                  fillColor: DockColors.background,
                                ),
                                focusColor: DockColors.white,
                                value: state.selectedNr == ''
                                    ? null
                                    : state.selectedNr,
                                onChanged: (String? newValue) {
                                  context
                                      .read<CadastrarCubit>()
                                      .updateSelectedNr(
                                        newValue ?? '',
                                      );
                                },
                                items: NrsEnum.nrs
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: SizedBox(
                                        width: 600,
                                        child: Text(value,
                                            overflow: TextOverflow.ellipsis)),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InkWell(
                                onTap: () => state.selectedNr != ''
                                    ? context
                                        .read<CadastrarCubit>()
                                        .addNrType(state.selectedNr)
                                    : null,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: state.selectedNr != ''
                                        ? DockColors.success100
                                        : DockColors.slate100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.add,
                                        color: DockColors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<CadastrarCubit>().resetState();
              },
              child: const Text('Fechar',
                  style: TextStyle(color: DockColors.danger100)),
            ),
            TextButton(
              onPressed: () {
                context.read<CadastrarCubit>().createEvent(
                      name,
                      email,
                      empresa,
                      funcao,
                      cpf,
                      bloodType,
                    );
                Navigator.of(context).pop();
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
