<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase; // 1. Add this import

class AuthTest extends TestCase
{
    /**
     * A basic feature test example.
     */
    use RefreshDatabase; // 2. Add this line inside the class

    public function test_user_can_login_and_receive_token(): void
    {
        // 1. Create a user in the test database
        $user = User::factory()->create([
            'password' => bcrypt('password123'),
        ]);

        // 2. Hit the login endpoint
        $response = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => 'password123',
        ]);

        // 3. Assertions (Expectations)
        $response->assertStatus(200)
            ->assertJsonStructure(['user', 'token']);
    }
}
