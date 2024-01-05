class UserModel {
  final String? id;
  final String email;
  final String password;
  final bool type;

  //String imageUrl;

  const UserModel(
      {this.id,
        required this.email,
        required this.password,
        required this.type});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'type': type
  };
}