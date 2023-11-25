<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Photo extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    protected $withCount = [
        'likes',
        'tags',
    ];

    public function galery(): BelongsTo
    {
        return $this->belongsTo(Galery::class);
    }

    public function tags(): BelongsToMany
    {
        return $this->belongsToMany(Tag::class)->using(PhotoTag::class);
    }

    public function likes(): BelongsToMany
    {
        return $this->belongsToMany(User::class)->using(PhotoLike::class);
    }

    public function users(): BelongsToMany
    {
        return $this->belongsToMany(User::class)->using(PhotoUser::class);
    }
}
