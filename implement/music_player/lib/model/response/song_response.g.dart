// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongResponse _$SongResponseFromJson(Map<String, dynamic> json) => SongResponse(
  id: json['id'] as String,
  name: json['name'] as String,
  singer: json['singer'] as String,
  path: json['path'] as String,
  imagePath: json['imagePath'] as String,
);

Map<String, dynamic> _$SongResponseToJson(SongResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'singer': instance.singer,
      'path': instance.path,
      'imagePath': instance.imagePath,
    };
