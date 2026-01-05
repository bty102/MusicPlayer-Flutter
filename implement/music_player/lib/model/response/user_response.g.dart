// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  email: json['email'] as String,
  password: json['password'] as String,
  name: json['name'] as String,
  isMale: json['isMale'] as bool,
  age: (json['age'] as num).toInt(),
  phoneNumber: json['phoneNumber'] as String,
  address: json['address'] as String,
  bio: json['bio'] as String?,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'isMale': instance.isMale,
      'age': instance.age,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'bio': instance.bio,
      'id': instance.id,
    };
