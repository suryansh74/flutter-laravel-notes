<?php

namespace Tests\Feature;

use App\Models\Note;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase; // 1. Add this import

class NoteTest extends TestCase
{
    use RefreshDatabase; // 2. Add this line inside the class

    /**
     * A basic feature test example.
     */
    public function test_user_cannot_view_someone_elses_notes(): void
    {
        // 1. Create two users
        $userA = User::factory()->create();
        $userB = User::factory()->create();

        // 2. Give User B a note
        $noteForB = Note::factory()->create(['user_id' => $userB->id]);

        // 3. Act as User A and try to view User B's note
        /** @var User $userA */
        $response = $this->actingAs($userA)
            ->getJson("/api/notes/{$noteForB->id}");

        // 4. Assert that access is forbidden
        $response->assertStatus(403);
    }
}
