import 'package:dockcheck_web/utils/colors.dart';
import 'package:dockcheck_web/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/projects/bloc/project_cubit.dart';
import '../features/projects/bloc/project_state.dart';// Make sure to import your ProjectCubit correctly

class FilePickerWidget extends StatefulWidget {
  final String title;

  const FilePickerWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      // Call the Cubit method to add files
      for (var file in result.files) {
        
        context.read<ProjectCubit>().addFile(file.name); // Assumes addFile takes a filename string
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: _pickFiles,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.attach_file),
                      const SizedBox(width: 8),
                      Text('Anexar Arquivos', style: DockTheme.body,),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            // Displaying a list of selected files
            if (state.fileNames.isNotEmpty)
              Wrap(
                children: state.fileNames
                    .map((fileName) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 0),
                      child: Chip(
                            label: Text(fileName),
                            deleteIconColor: DockColors.danger110,
                            padding: const EdgeInsets.all(4),
                            onDeleted: () => context.read<ProjectCubit>().removeFile(fileName),
                          ),
                    ))
                    .toList(),
              ),
          ],
        );
      },
    );
  }
}
