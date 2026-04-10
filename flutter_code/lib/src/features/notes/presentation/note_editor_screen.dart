import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/src/features/notes/domain/note.dart';
import 'package:notes_app/src/features/notes/presentation/notes_controller.dart';

class NoteEditorScreen extends ConsumerStatefulWidget {
  // Add an optional Note parameter
  final Note? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // If we are editing an existing note, pre-fill the text fields!
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _bodyController.text = widget.note!.body;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Change the title based on whether we are creating or editing
    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'New Note'),
        actions: [
          IconButton(
            icon: _isLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.check),
            onPressed: _isLoading
                ? null
                : () async {
                    if (_titleController.text.isEmpty ||
                        _bodyController.text.isEmpty) {
                      return;
                    }

                    setState(() => _isLoading = true);

                    try {
                      if (isEditing) {
                        // UPDATE EXISTING NOTE
                        await ref
                            .read(notesProvider.notifier)
                            .updateNote(
                              widget.note!.id,
                              _titleController.text,
                              _bodyController.text,
                            );
                      } else {
                        // CREATE NEW NOTE
                        await ref
                            .read(notesProvider.notifier)
                            .addNote(
                              _titleController.text,
                              _bodyController.text,
                            );
                      }

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    } finally {
                      if (mounted) setState(() => _isLoading = false);
                    }
                  },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Note Title',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: TextField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  hintText: 'Write your note here...',
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

