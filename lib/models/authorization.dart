class Authorization {
  String id;
  String thirdProjectId;
  DateTime expirationDate;
  String employeeId;
  String status;

  Authorization({
    required this.id,
    required this.thirdProjectId,
    required this.expirationDate,
    required this.employeeId,
    required this.status,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) {
    return Authorization(
      id: json['id'],
      thirdProjectId: json['third_project_id'],
      expirationDate: DateTime.parse(json['expiration_date']),
      employeeId: json['employee_id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'third_project_id': thirdProjectId,
      'expiration_date': expirationDate.toIso8601String(),
      'employee_id': employeeId,
      'status': status,
    };
  }

  Authorization copyWith({
    String? id,
    String? thirdProjectId,
    DateTime? expirationDate,
    String? employeeId,
    String? status,
  }) {
    return Authorization(
      id: id ?? this.id,
      thirdProjectId: thirdProjectId ?? this.thirdProjectId,
      expirationDate: expirationDate ?? this.expirationDate,
      employeeId: employeeId ?? this.employeeId,
      status: status ?? this.status,
    );
  }
}
