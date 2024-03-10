import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectState {
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final String vesselId;
  final String companyId;
  final List<String> thirdCompaniesId;
  final List<String> adminsId;
  final List<String> areasId;
  final bool isDocking;
  final String address;
  final String status;
  final bool isLoading;
  final bool projectCreated;
  final String errorMessage;

  ProjectState({
    this.name = '',
    this.startDate,
    this.endDate,
    this.vesselId = '',
    this.companyId = '',
    this.thirdCompaniesId = const [],
    this.adminsId = const [],
    this.areasId = const [],
    this.isDocking = false,
    this.address = '',
    this.status = '',
    this.isLoading = false,
    this.projectCreated = false,
    this.errorMessage = '',
  });

  ProjectState copyWith({
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    String? vesselId,
    String? companyId,
    List<String>? thirdCompaniesId,
    List<String>? adminsId,
    List<String>? areasId,
    bool? isDocking,
    String? address,
    String? status,
    bool? isLoading,
    bool? projectCreated,
    String? errorMessage,
  }) {
    return ProjectState(
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      vesselId: vesselId ?? this.vesselId,
      companyId: companyId ?? this.companyId,
      thirdCompaniesId: thirdCompaniesId ?? this.thirdCompaniesId,
      adminsId: adminsId ?? this.adminsId,
      areasId: areasId ?? this.areasId,
      isDocking: isDocking ?? this.isDocking,
      address: address ?? this.address,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      projectCreated: projectCreated ?? this.projectCreated,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
