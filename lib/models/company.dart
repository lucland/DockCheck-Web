class Company {
  String id;
  String name;
  String logo;
  String razaoSocial;
  String cnpj;
  String address;
  String telephone;
  String email;
  String status;

  Company({
    required this.id,
    required this.name,
    required this.logo,
    required this.razaoSocial,
    required this.cnpj,
    required this.address,
    required this.telephone,
    required this.email,
    required this.status,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      razaoSocial: json['razao_social'],
      cnpj: json['cnpj'],
      address: json['address'],
      telephone: json['telephone'],
      email: json['email'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'razao_social': razaoSocial,
      'cnpj': cnpj,
      'address': address,
      'telephone': telephone,
      'email': email,
      'status': status,
    };
  }

  Company copyWith({
    String? id,
    String? name,
    String? logo,
    String? razaoSocial,
    String? cnpj,
    String? address,
    String? telephone,
    String? email,
    String? status,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      razaoSocial: razaoSocial ?? this.razaoSocial,
      cnpj: cnpj ?? this.cnpj,
      address: address ?? this.address,
      telephone: telephone ?? this.telephone,
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }
}
