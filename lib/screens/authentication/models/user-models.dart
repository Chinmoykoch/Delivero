class UserModel {
  final String name;
  final String email;
  final String password;

  UserModel({required this.name, required this.email, required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, password: $password)';
  }
}
