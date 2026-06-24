class UserModel {
  final int id;
  final String name;
  final String email;
  final String company;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.company,
  });

  // Converte o JSON em uma instância de UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      company: json['company']['name'] ?? 'Sem empresa',
    );
  }
}
