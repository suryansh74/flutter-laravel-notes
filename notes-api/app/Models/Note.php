<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model; // 1. Add this import

class Note extends Model
{
    use HasFactory; // 2. Add this line inside the class

    protected $fillable = ['user_id', 'title', 'body'];

    // app/Models/Note.php
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
