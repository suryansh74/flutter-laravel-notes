import 'package:dio/dio.dart';
import 'package:notes_app/src/features/notes/domain/note.dart';
import 'package:notes_app/src/shared/network/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_repository.g.dart';

class NoteRepository {
  NoteRepository(this._dio);
  final Dio _dio;

  Future<List<Note>> getNotes() async {
    try {
      final response = await _dio.get('/notes');
      final List<dynamic> data = response.data;
      return data.map((json) => Note.fromJson(json)).toList();
    } catch (e) {
      throw 'Failed to fetch notes';
    }
  }

  // --- NEW METHODS ---

  Future<Note> createNote(String title, String body) async {
    try {
      final response = await _dio.post(
        '/notes',
        data: {'title': title, 'body': body},
      );
      return Note.fromJson(response.data);
    } catch (e) {
      throw 'Failed to create note';
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await _dio.delete('/notes/$id');
    } catch (e) {
      throw 'Failed to delete note';
    }
  }

  Future<Note> updateNote(int id, String title, String body) async {
    try {
      // Laravel uses PUT for updating existing resources
      final response = await _dio.put(
        '/notes/$id',
        data: {'title': title, 'body': body},
      );
      return Note.fromJson(response.data);
    } catch (e) {
      throw 'Failed to update note';
    }
  }
}

@riverpod
NoteRepository noteRepository(Ref ref) {
  return NoteRepository(ref.watch(dioProvider));
}
