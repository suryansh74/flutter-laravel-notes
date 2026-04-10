<?php

namespace Database\Seeders;

use App\Models\Note;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // 1. Create a specific test user so you can log in easily
        $user = User::factory()->create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password123'),
        ]);

        // 2. Create 10 notes for that specific user
        Note::factory()
            ->count(10)
            ->create(['user_id' => $user->id]);

        // 3. Create 5 other random users with 3 notes each
        User::factory()
            ->count(5)
            ->hasNotes(3) // Requires a 'notes' relationship in User model
            ->create();
    }
}
