<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Angkatan extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    protected $casts = [
        'tahun' => 'integer',
    ];

    protected $withCount = [
        'galeries',
        'students',
    ];

    public function galeries(): HasMany
    {
        return $this->hasMany(Galery::class);
    }

    public function students(): HasMany
    {
        return $this->hasMany(Student::class);
    }
}
