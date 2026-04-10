// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  title: json['title'] as String,
  body: json['body'] as String,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'title': instance.title,
  'body': instance.body,
  'created_at': instance.createdAt,
};
