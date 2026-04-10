import 'package:notes_app/src/features/notes/data/note_repository.dart';
import 'package:notes_app/src/features/notes/domain/note.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notes_controller.g.dart';

@riverpod
class Notes extends _$Notes {
  @override
  FutureOr<List<Note>> build() async {
    return ref.read(noteRepositoryProvider).getNotes();
  }

  Future<void> addNote(String title, String body) async {
    // 1. Send to Laravel
    final newNote = await ref
        .read(noteRepositoryProvider)
        .createNote(title, body);

    // 2. Update the UI list instantly using state.value instead of valueOrNull
    final currentNotes = state.value ?? [];
    state = AsyncData([newNote, ...currentNotes]);
  }

  Future<void> deleteNote(int id) async {
    // 1. Tell Laravel to delete it
    await ref.read(noteRepositoryProvider).deleteNote(id);

    // 2. Remove it from the Flutter UI instantly
    final currentNotes = state.value ?? [];
    state = AsyncData(currentNotes.where((note) => note.id != id).toList());
  }

  Future<void> updateNote(int id, String title, String body) async {
    // 1. Tell Laravel to update the note
    final updatedNote = await ref
        .read(noteRepositoryProvider)
        .updateNote(id, title, body);

    // 2. Find the old note in our list and replace it with the new one
    final currentNotes = state.value ?? [];
    state = AsyncData([
      for (final note in currentNotes)
        if (note.id == id) updatedNote else note,
    ]);
  }
}
