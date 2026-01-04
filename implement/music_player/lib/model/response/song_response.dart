import 'package:json_annotation/json_annotation.dart';

part 'song_response.g.dart';

@JsonSerializable()
class SongResponse {
  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "singer")
  String singer;

  @JsonKey(name: "path")
  String path;

  @JsonKey(name: "imagePath")
  String imagePath;

  SongResponse({
    required this.id,
    required this.name,
    required this.singer,
    required this.path,
    required this.imagePath,
  });

  factory SongResponse.fromJson(Map<String, dynamic> json) =>
      _$SongResponseFromJson(json);
}
