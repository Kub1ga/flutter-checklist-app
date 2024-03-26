class RegisterModels {
  final String email;
  final String username;
  final String password;

  RegisterModels(
      {required this.email, required this.username, required this.password});

  factory RegisterModels.fromJson(Map<String, dynamic> json) {
    return RegisterModels(
      email: json['email'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
    };
  }
}
