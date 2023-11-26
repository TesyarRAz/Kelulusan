<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\MorphMany;

class Galery extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    protected $with = [
        'kelas',
        'angkatan',
    ];

    protected $withCount = [
        'photos',
        'likes',
    ];

    public function photos(): HasMany
    {
        return $this->hasMany(Photo::class);
    }

    public function kelas(): BelongsTo
    {
        return $this->belongsTo(Kelas::class);
    }

    public function angkatan(): BelongsTo
    {
        return $this->belongsTo(Angkatan::class);
    }

    public function likes(): MorphMany
    {
        return $this->morphMany(ModelLike::class, 'modelable');
    }
}
