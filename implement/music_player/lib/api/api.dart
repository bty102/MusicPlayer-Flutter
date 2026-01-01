import 'package:dio/dio.dart';
import 'package:music_player/model/request/user_register_request.dart';
import 'package:music_player/model/response/token.dart';

class Api {
  static final String protocol = "http";
  static final String host = "localhost";
  static final String port = "3000";

  Future<Token?> register(UserRegisterRequest request) async {
    Token? token = null;
    String url = """${Api.protocol}://${Api.host}:${Api.port}/register""";
    var dio = Dio();
    var response = await dio.post(
      url,
      data: {
        "email": request.email,
        "password": request.password,
        "name": request.name,
        "isMale": request.isMale,
        "age": request.age,
        "phoneNumber": request.phoneNumber,
        "address": request.address,
        "bio": request.bio,
      },
    );

    if (response.statusCode == 201) {
      token = Token.fromJson(response.data as Map<String, dynamic>);
    }
    return token;
  }
}
