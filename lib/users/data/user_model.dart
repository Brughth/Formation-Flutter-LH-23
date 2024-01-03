class UserModel {
  final String id;
  final String name;
  final String email;
  final String tel;
  final String? image;
  final String? createAt;
  final String? updateAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.tel,
    this.image,
    this.createAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "tel": tel,
      "image": image,
      "updateAt": updateAt,
      "createAt": createAt,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      tel: json['tel'],
      image: json['image'],
      createAt: json['createAt'],
      updateAt: json['updateAt'],
    );
  }
}
