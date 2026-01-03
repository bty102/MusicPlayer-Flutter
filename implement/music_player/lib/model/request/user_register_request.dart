class UserRegisterRequest {
  String email;
  String password;
  String name;
  bool isMale;
  int age;
  String phoneNumber;
  String address;
  String? bio = null;

  UserRegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.isMale,
    required this.age,
    required this.phoneNumber,
    required this.address,
    this.bio,
  });
}
