import 'package:dockcheck_web/features/invite/invite.dart';
import 'package:flutter/material.dart';

import '../models/project.dart';
import '../utils/colors.dart';
import '../utils/theme.dart';

class ProjectDetailsModal extends StatelessWidget {
  //it receives a Project object
  const ProjectDetailsModal({Key? key, required this.project})
      : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: DockColors.white,
      surfaceTintColor: DockColors.white,
      title: Text('Detalhes do projeto'), // You can make this dynamic as needed
      content: SizedBox(
        width: 800,
        height: MediaQuery.of(context).size.height - 300,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(project.name,
                      style: DockTheme.h2.copyWith(
                        color: DockColors.iron100,
                      )),
                  //a DockColors.iron100 badge with slitghly rounded corners containing a white bold text with the project.isDocking value
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: DockColors.iron100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      project.isDocking ? 'DOCAGEM' : 'MOBILIZAÇÃO',
                      style: TextStyle(
                        color: DockColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              //project dateStart - dateEnd text
              Text(
                'Data de Início: ${project.dateStart}',
                style: DockTheme.h2.copyWith(
                  color: DockColors.iron100,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Data de Término: ${project.dateEnd}',
                style: DockTheme.h2.copyWith(
                  color: DockColors.iron100,
                ),
              ),
              SizedBox(height: 8),
              // New text for the project.address
              Text(
                'Endereço: ${project.address}',
                style: DockTheme.h2.copyWith(
                  color: DockColors.iron100,
                ),
              ),
              //button calling the InvitePage passing the project.id
              InviteWidget(projectId: project.id)
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK', style: TextStyle(color: DockColors.iron100)),
        ),
      ],
    );
  }
}
