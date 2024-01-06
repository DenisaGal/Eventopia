class UserModel {
  final String? id;
  final String email;
  final String? password;
  final bool isOrganizer;

  //String imageUrl;

  const UserModel({
    this.id,
    required this.email,
    this.password,
    required this.isOrganizer,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      isOrganizer: json['isOrganizer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'isOrganizer': isOrganizer,
      };
}
