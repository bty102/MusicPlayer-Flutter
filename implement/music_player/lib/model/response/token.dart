import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: "accessToken")
  String accessToken;

  Token({required this.accessToken});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}
