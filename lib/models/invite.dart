class Invite {
  String id;
  String email;
  bool accepted;
  bool sent;
  String thirdCompanyName;
  DateTime dateSent;
  bool viewed;

  Invite({
    required this.id,
    required this.email,
    required this.accepted,
    required this.sent,
    required this.thirdCompanyName,
    required this.dateSent,
    required this.viewed,
  });

  factory Invite.fromJson(Map<String, dynamic> json) {
    return Invite(
      id: json['id'],
      email: json['email'],
      accepted: json['accepted'],
      sent: json['sent'],
      thirdCompanyName: json['thirdCompanyName'],
      dateSent: DateTime.parse(json['dateSent']),
      viewed: json['viewed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'accepted': accepted,
      'sent': sent,
      'thirdCompanyName': thirdCompanyName,
      'dateSent': dateSent.toIso8601String(),
      'viewed': viewed,
    };
  }

  Invite copyWith({
    String? id,
    String? email,
    bool? accepted,
    bool? sent,
    String? thirdCompanyName,
    DateTime? dateSent,
    bool? viewed,
  }) {
    return Invite(
      id: id ?? this.id,
      email: email ?? this.email,
      accepted: accepted ?? this.accepted,
      sent: sent ?? this.sent,
      thirdCompanyName: thirdCompanyName ?? this.thirdCompanyName,
      dateSent: dateSent ?? this.dateSent,
      viewed: viewed ?? this.viewed,
    );
  }
}
