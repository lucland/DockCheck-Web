class Project {
  String id;
  String name;
  DateTime dateStart;
  DateTime dateEnd;
  String vesselId;
  String companyId;
  List<String> thirdCompaniesId;
  List<String> adminsId;
  List<String> areasId;
  String address;
  bool isDocking;
  String status;

  Project({
    required this.id,
    required this.name,
    required this.dateStart,
    required this.dateEnd,
    required this.vesselId,
    required this.companyId,
    required this.thirdCompaniesId,
    required this.adminsId,
    required this.areasId,
    required this.address,
    required this.isDocking,
    required this.status,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      dateStart: DateTime.parse(json['date_start']),
      dateEnd: DateTime.parse(json['date_end']),
      vesselId: json['vessel_id'],
      companyId: json['company_id'],
      thirdCompaniesId: List<String>.from(json['third_companies_id']),
      adminsId: List<String>.from(json['admins_id']),
      areasId: List<String>.from(json['areas_id']),
      address: json['address'],
      isDocking: json['is_docking'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date_start': dateStart.toIso8601String(),
      'date_end': dateEnd.toIso8601String(),
      'vessel_id': vesselId,
      'company_id': companyId,
      'third_companies_id': thirdCompaniesId,
      'admins_id': adminsId,
      'areas_id': areasId,
      'address': address,
      'is_docking': isDocking,
      'status': status,
    };
  }

  Project copyWith({
    String? id,
    String? name,
    DateTime? dateStart,
    DateTime? dateEnd,
    String? vesselId,
    String? companyId,
    List<String>? thirdCompaniesId,
    List<String>? adminsId,
    List<String>? areasId,
    String? address,
    bool? isDocking,
    String? status,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      vesselId: vesselId ?? this.vesselId,
      companyId: companyId ?? this.companyId,
      thirdCompaniesId: thirdCompaniesId ?? this.thirdCompaniesId,
      adminsId: adminsId ?? this.adminsId,
      areasId: areasId ?? this.areasId,
      address: address ?? this.address,
      isDocking: isDocking ?? this.isDocking,
      status: status ?? this.status,
    );
  }
}
