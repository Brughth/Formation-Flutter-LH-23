class UserModel {
  final String id;
  final String name;
  final String email;
  final String? createAt;
  final String? updateAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.createAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "updateAt": updateAt,
      "createAt": createAt,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createAt: json['createAt'],
      updateAt: json['updateAt'],
    );
  }
}
