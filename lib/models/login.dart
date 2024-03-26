class LoginModels {
  final String username;
  final String password;

  LoginModels({required this.username, required this.password});

  factory LoginModels.fromJson(Map<String, dynamic> json) {
    return LoginModels(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
