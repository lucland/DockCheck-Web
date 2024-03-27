import 'package:dockcheck_web/widgets/image_picker_widget.dart';
import 'package:file_picker/file_picker.dart';
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
        Future<void> _pickFile(BuildContext context, String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final PlatformFile file = result.files.first;
      DateTime? expirationDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (expirationDate != null) {
        context.read<CadastrarCubit>().addDocument(file, expirationDate, type); // Trigger addDocument with the selected file and date
      }
    }
  }
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
                                  child: Text('Embarcação',
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
                      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
          Row(
            children: [
              Flexible(
                child: Text(
                  DockStrings.aso,
                  style: DockTheme.h2.copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
                Text(
                  '*',
                  style: DockTheme.h2.copyWith(color: DockColors.danger100, fontSize: 18),
                ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        suffixIcon: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: DockColors.slate100,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        hintText: DockStrings.aso,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: DockColors.slate100,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: DockColors.slate100,
                            width: 1.0,
                          ),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        _pickFile(context, "ASO");
                      },
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: () => _pickFile(context, "ASO"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: DockColors.slate100,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.attach_file,
                              color: DockColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (state.documents.any((document) => document.type == "ASO"))
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Documento enviado com sucesso',
                    style: DockTheme.h3.copyWith(
                      color: DockColors.success100,
                      fontSize: 15,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
                      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
          Row(
            children: [
              Flexible(
                child: Text(
                  DockStrings.nr34,
                  style: DockTheme.h2.copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
                Text(
                  '*',
                  style: DockTheme.h2.copyWith(color: DockColors.danger100, fontSize: 18),
                ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        suffixIcon: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: DockColors.slate100,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        hintText: DockStrings.aso,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: DockColors.slate100,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: DockColors.slate100,
                            width: 1.0,
                          ),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        _pickFile(context, "NR-34");
                      },
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: () => _pickFile(context, "NR-34"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: DockColors.slate100,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.attach_file,
                              color: DockColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            if (state.documents.any((document) => document.type == "NR-34"))
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Documento enviado com sucesso',
                    style: DockTheme.h3.copyWith(
                      color: DockColors.success100,
                      fontSize: 15,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
                      ...state.nrTypes.map(
                        (nrType) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
          Row(
            children: [
              Flexible(
                child: Text(
                  nrType,
                  style: DockTheme.h2.copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
                Text(
                  '*',
                  style: DockTheme.h2.copyWith(color: DockColors.danger100, fontSize: 18),
                ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        suffixIcon: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: DockColors.slate100,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        hintText: DockStrings.aso,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: DockColors.slate100,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: DockColors.slate100,
                            width: 1.0,
                          ),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        _pickFile(context, nrType);
                      },
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: () => _pickFile(context, nrType),
                        child: Container(
                          decoration: BoxDecoration(
                            color: DockColors.slate100,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.attach_file,
                              color: DockColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
               if (state.documents.any((document) => document.type == nrType))
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Documento enviado com sucesso',
                    style: DockTheme.h3.copyWith(
                      color: DockColors.success100,
                      fontSize: 15,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
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
