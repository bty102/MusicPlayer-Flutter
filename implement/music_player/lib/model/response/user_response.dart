import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "password")
  String password;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "isMale")
  bool isMale;

  @JsonKey(name: "age")
  int age;

  @JsonKey(name: "phoneNumber")
  String phoneNumber;

  @JsonKey(name: "address")
  String address;

  @JsonKey(name: "bio")
  String? bio;

  @JsonKey(name: "id")
  int id;

  UserResponse({
    required this.email,
    required this.password,
    required this.name,
    required this.isMale,
    required this.age,
    required this.phoneNumber,
    required this.address,
    this.bio,
    required this.id,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
