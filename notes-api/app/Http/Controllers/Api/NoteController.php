<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Note;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth; // <--- 1. Add this import

class NoteController extends Controller
{
    public function index()
    {
        // 2. Use Auth::id() instead of auth()->id()
        return Note::where('user_id', Auth::id())->latest()->get();
    }

    public function store(Request $request)
    {
        $fields = $request->validate([
            'title' => 'required|string|max:255',
            'body' => 'required|string',
        ]);

        $note = Note::create([
            'user_id' => Auth::id(),
            'title' => $fields['title'],
            'body' => $fields['body'],
        ]);

        return response($note, 201);
    }

    public function show(Note $note)
    {
        if ($note->user_id !== Auth::id()) {
            return response(['message' => 'Unauthorized'], 403);
        }

        return $note;
    }

    public function update(Request $request, Note $note)
    {
        if ($note->user_id !== Auth::id()) {
            return response(['message' => 'Unauthorized'], 403);
        }

        $fields = $request->validate([
            'title' => 'sometimes|string',
            'body' => 'sometimes|string',
        ]);

        $note->update($fields);

        return $note;
    }

    public function destroy(Note $note)
    {
        if ($note->user_id !== Auth::id()) {
            return response(['message' => 'Unauthorized'], 403);
        }

        $note->delete();

        return response(['message' => 'Note deleted'], 200);
    }
}
