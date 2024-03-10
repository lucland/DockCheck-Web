import 'package:dockcheck_web/features/home/bloc/cadastrar_cubit.dart';
import 'package:dockcheck_web/widgets/file_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Intl package for date formatting

import '../features/projects/bloc/project_cubit.dart';
import '../features/projects/bloc/project_state.dart';
import '../widgets/text_input_widget.dart';
import '../widgets/calendar_picker_widget.dart'; // Assume you have this for selecting items from a list
import '../utils/colors.dart';
import '../utils/strings.dart';
import '../utils/theme.dart';

class ProjectModal extends StatelessWidget {
  const ProjectModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: DockColors.white,
          surfaceTintColor: DockColors.white,
          title:
              Text('Adicionar Projeto'), // You can make this dynamic as needed
          content: SizedBox(
            width: 800,
            height: MediaQuery.of(context).size.height - 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInputWidget(
                    title: 'Nome do Projeto',
                    isRequired: true,
                    controller: TextEditingController(),
                    onChanged: (text) =>
                        context.read<ProjectCubit>().updateName(text),
                  ),
                  SizedBox(height: 8),
                  CalendarPickerWidget(
                    title: 'Data de Início',
                    isRequired: true,
                    showAttachmentIcon: false,
                    controller: TextEditingController(),
                    onChanged: (date) =>
                        context.read<ProjectCubit>().updateStartDate(date),
                  ),
                  SizedBox(height: 8),
                  CalendarPickerWidget(
                    title: 'Data de Término',
                    isRequired: true,
                    showAttachmentIcon: false,
                    controller: TextEditingController(),
                    onChanged: (date) =>
                        context.read<ProjectCubit>().updateEndDate(date),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 4.0), // Adjust padding as needed
                        child: ChoiceChip(
                          label: Text(state.isDocking ? 'Docagem' : 'Docagem'),
                          selected: state.isDocking,
                          onSelected: (bool selected) {
                            // Toggle the state.isDocking value
                            context
                                .read<ProjectCubit>()
                                .updateIsDocking(!state.isDocking);
                          }, // Adjust the color as needed
                          selectedColor:
                              DockColors.iron100, // Adjust the color as needed
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(
                              state.isDocking ? 'Mobilização' : 'Mobilização'),
                          selected: !state.isDocking,
                          onSelected: (bool selected) {
                            // Toggle the state.isDocking value
                            context
                                .read<ProjectCubit>()
                                .updateIsDocking(!state.isDocking);
                          }, // Adjust the color as needed
                          selectedColor:
                              DockColors.iron100, // Adjust the color as needed
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // New TextInputWidget for "Endereço"
                  TextInputWidget(
                    title: 'Endereço',
                    isRequired: false, // Set based on your requirement
                    controller: TextEditingController(),
                    onChanged: (text) => context
                        .read<ProjectCubit>()
                        .updateName(
                            text), // Implement this method in your cubit
                  ),
                  SizedBox(height: 8),
                  // New FilePickerWidget for "Blueprints do projeto"
                  FilePickerWidget(
                    title: 'Blueprints do Projeto',
                    onFilePicked: (file) {
                      // Handle file picking logic, assume you have a method in your cubit for this
                      context.read<ProjectCubit>().updateIsDocking(true);
                    },
                  ),
                  SizedBox(height: 8),
                  // New TextInputWidget for "Convidar empresa terceira"
                  TextInputWidget(
                    title: 'Convidar Empresa Terceira',
                    isRequired: false,
                    controller: TextEditingController(),
                    onChanged: (text) => context
                        .read<ProjectCubit>()
                        .updateIsDocking(
                            true), // Implement this method in your cubit
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar',
                  style: TextStyle(color: DockColors.danger100)),
            ),
            TextButton(
              onPressed: () {
                context.read<ProjectCubit>().createProject();
                Navigator.of(context).pop();
              },
              child: Text('Adicionar Projeto'),
            ),
          ],
        );
      },
    );
  }
}
