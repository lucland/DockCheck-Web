import 'package:dockcheck_web/features/home/bloc/pesquisar_cubit.dart';
import 'package:dockcheck_web/features/invite/invite.dart';
import 'package:dockcheck_web/features/projects/bloc/project_cubit.dart';
import 'package:dockcheck_web/features/projects/bloc/project_state.dart';
import 'package:dockcheck_web/models/employee.dart';
import 'package:dockcheck_web/models/project.dart';
import 'package:dockcheck_web/widgets/project_details_modal.dart';
import 'package:dockcheck_web/widgets/project_modal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../details/details.dart';
import '../home/bloc/pesquisar_state.dart';

class Projects extends StatelessWidget {
  const Projects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ProjectCubit>().fetchProjects();

    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        if (state.isLoading) {
          return SizedBox(
              width: MediaQuery.of(context).size.width - 300,
              child: const Center(
                child: CircularProgressIndicator(),
              ));
        } else {
          List<Project> allProjects = state.projects;

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
                          openModal(context, '');
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
                      child: !state.isLoading && state.projects.isNotEmpty
                          ? ListView.builder(
                              itemCount: allProjects.length,
                              itemBuilder: (context, index) {
                                //Employee employee = displayEmployees[index];
                                Project project = allProjects[index];
                                return _buildProjectListTile(context, project);
                              },
                            )
                          : Center(
                              child: Text(
                                'Nenhum projeto encontrado',
                                style: DockTheme.h2.copyWith(
                                  color: DockColors.iron100,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildProjectListTile(BuildContext context, Project project) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: Image.asset(
                            'assets/svg/skandi_iguacu.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(project.name,
                                    style: DockTheme.h1.copyWith(
                                      color: DockColors.iron100,
                                    )),
                                Spacer(),
                                //a DockColors.iron100 badge with slitghly rounded corners containing a white bold text with the project.isDocking value
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: DockColors.iron100, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    project.isDocking
                                        ? 'DOCAGEM'
                                        : 'MOBILIZAÇÃO',
                                    style: DockTheme.body.copyWith(
                                      color: DockColors.iron100,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 16.0),
                              child: Divider(
                                color: DockColors.slate100.withAlpha(100),
                                thickness: 1,
                              ),
                            ),
                            Text(
                              project.address,
                              style: DockTheme.h2.copyWith(
                                color: DockColors.slate110,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${'${project.dateStart.day}/${project.dateStart.month}/${project.dateStart.year}'} - ${'${project.dateEnd.day}/${project.dateEnd.month}/${project.dateEnd.year}'}',
                              style: DockTheme.h2.copyWith(
                                color: DockColors.iron100,
                                fontSize: 14,
                              ),
                            ),
                            Spacer(),
                            InviteWidget(projectId: project.id),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  //open modal with project details function
  void openDetailsModal(BuildContext context, Project project) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ProjectDetailsModal(
          project: project,
        );
      },
    );
  }

  void openModal(BuildContext context, String s) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ProjectModal();
      },
    );
  }
}
