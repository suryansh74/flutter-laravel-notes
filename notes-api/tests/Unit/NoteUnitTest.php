<?php

namespace Tests\Unit;

use App\Models\Note;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
// CHANGE THIS LINE:
use Tests\TestCase;

// Ensure it extends the Laravel TestCase, not the PHPUnit one
class NoteUnitTest extends TestCase
{
    use RefreshDatabase;

    public function test_note_belongs_to_a_user(): void
    {
        $user = User::factory()->create();
        $note = Note::factory()->create(['user_id' => $user->id]);

        $this->assertInstanceOf(User::class, $note->user);
        $this->assertEquals($user->id, $note->user->id);
    }
}
