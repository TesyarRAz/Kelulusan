<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Photo;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

class PhotoController extends Controller
{
    public function index(Request $request)
    {
        $photos = Photo::select('photos.*')
        ->with('galery')
        ->withExists(['likes as like_by_you' => fn(Builder $query) => $query->where('user_id', auth()->id())])
        ->where(fn($query) => $query
            ->when($request->has('angkatan'), fn(Builder $query) => $query->whereHas('angkatan', $request->angkatan))
            ->when($request->has('kelas'), fn(Builder $query) => $query->whereHas('kelas', $request->kelas))
        )
        ->get();

        return response()->json([
            'data' => $photos,
        ]);
    }

    public function show(Photo $photo)
    {
        $photo->load('galery');

        return response()->json([
            'data' => $photo,
        ]);
    }

    public function like(Photo $photo)
    {
        $photo->likes()->updateOrCreate([
            'user_id' => auth()->id(),
        ]);

        return response()->json([
            'message' => 'Liked'
        ]);
    }

    public function unlike(Photo $photo)
    {
        $photo->likes()->where([
            'user_id' => auth()->id(),
        ])->delete();

        return response()->json([
            'message' => 'Unliked'
        ]);
    }
}
