import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:music_player/model/request/user_login_request.dart';
import 'package:music_player/model/request/user_register_request.dart';
import 'package:music_player/model/response/song_response.dart';
import 'package:music_player/model/response/token.dart';
import 'package:music_player/model/response/user_response.dart';

class Api {
  static final String protocol = "http";
  static final String host = "localhost";
  static final String port = "3000";

  Future<Token?> register(UserRegisterRequest request) async {
    Token? token = null;
    String url = """${Api.protocol}://${Api.host}:${Api.port}/register""";
    var dio = Dio();
    try {
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
    } on DioException catch (e) {
      return token;
    }
  }

  Future<Token?> login(UserLoginRequest request) async {
    Token? token = null;
    String url = """${Api.protocol}://${Api.host}:${Api.port}/login""";
    var dio = Dio();

    try {
      var response = await dio.post(
        url,
        data: {"email": request.email, "password": request.password},
      );

      if (response.statusCode == 200) {
        token = Token.fromJson(response.data as Map<String, dynamic>);
      }
      return token;
    } on DioException catch (e) {
      return token;
    }
  }

  Future<List<SongResponse>?> getSongs(String accessToken) async {
    List<SongResponse>? songs = null;
    String url = """${Api.protocol}://${Api.host}:${Api.port}/660/songs""";

    var dio = Dio();
    try {
      var response = await dio.request(
        url,
        options: Options(
          method: 'GET',
          headers: {"Authorization": "Bearer $accessToken"},
        ),
      );

      if (response.statusCode == 200) {
        List lst = response.data as List;
        songs = lst
            .map((e) => SongResponse.fromJson(e as Map<String, dynamic>))
            .toList();

        return songs;
      }
    } on DioException catch (e) {
      return songs;
    }
  }

  Future<UserResponse?> getMyInfo(String accessToken) async {
    UserResponse? user = null;

    Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);

    String userId = decodedToken['sub'];

    String url =
        """${Api.protocol}://${Api.host}:${Api.port}/600/users/$userId""";

    var dio = Dio();
    try {
      var response = await dio.request(
        url,
        options: Options(
          method: 'GET',
          headers: {"Authorization": "Bearer $accessToken"},
        ),
      );
      if (response.statusCode == 200) {
        user = UserResponse.fromJson(response.data as Map<String, dynamic>);
      }
      return user;
    } on DioException catch (e) {
      return user;
    }
  }
}
