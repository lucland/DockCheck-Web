import 'dart:convert';

import 'package:dockcheck_web/features/projects/bloc/project_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../models/document.dart';
import '../../../models/project.dart';
import '../../../repositories/project_repository.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final ProjectRepository projectRepository;

  ProjectCubit(this.projectRepository) : super(ProjectState());

  void updateName(String name) => emit(state.copyWith(name: name));

  void updateStartDate(DateTime startDate) =>
      emit(state.copyWith(startDate: startDate));

  void updateEndDate(DateTime endDate) =>
      emit(state.copyWith(endDate: endDate));

  void updateVesselId(String vesselId) =>
      emit(state.copyWith(vesselId: vesselId));

  void updateCompanyId(String companyId) =>
      emit(state.copyWith(companyId: companyId));

  void addFile(String fileName) {
    final updatedFileNames = List<String>.from(state.fileNames)..add(fileName);
   emit(state.copyWith(fileNames: updatedFileNames));
  }

  //turn the File to base64, create a Document object and add to the state
  void addDocument(PlatformFile file) {
    //turn file to base64
    final String base64 = base64Encode(file.bytes!);

    final updatedDocuments = List<Document>.from(state.documents)
      ..add(Document(
        id: const Uuid().v4(),
        type: file.extension ?? 'unknown',
        employeeId: loggedInUser.id,
        expirationDate: DateTime.now().add(const Duration(days: 365)),
        path: base64,
        status: 'pending',
      ));
    emit(state.copyWith(documents: updatedDocuments));
  }

void removeFile(String fileName) {
  final updatedFileNames = List<String>.from(state.fileNames)..remove(fileName);
  emit(state.copyWith(fileNames: updatedFileNames));
}

  //updateIsDocking
  void updateIsDocking(bool isDocking) =>
      emit(state.copyWith(isDocking: isDocking));

  // Implement other update methods following the pattern above

  void createProject() async {
    emit(state.copyWith(isLoading: true));

    try {
      final project = Project(
        id: const Uuid().v4(), // Generate a new UUID for the project
        name: state.name,
        dateStart: state.startDate!,
        dateEnd: state.endDate!,
        vesselId: state.vesselId,
        companyId: state.companyId,
        thirdCompaniesId: state.thirdCompaniesId,
        adminsId: state.adminsId,
        areasId: state.areasId,
        address: state.address,
        isDocking: state.isDocking,
        status: state.status,
      );
      await projectRepository.createProject(project);
      emit(state.copyWith(isLoading: false, projectCreated: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  //create File`s objects and upload to the server
}
