<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Galery;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

class GaleryController extends Controller
{
    public function index(Request $request)
    {
        $galery = Galery::select('galeries.*')
        ->with('photos')
        ->where(fn($query) => $query
            ->when($request->has('angkatan'), fn(Builder $query) => $query->whereHas('angkatan', $request->angkatan))
            ->when($request->has('kelas'), fn(Builder $query) => $query->whereHas('kelas', $request->kelas))
            ->when($request->has('search'), fn(Builder $query) => $query->where('name', 'like', "%{$request->search}%"))
        )
        ->get();

        return response()->json([
            'data' => $galery
        ]);
    }

    public function show(Galery $galery)
    {
        $galery->load('photos');

        return response()->json([
            'data' => $galery,
        ]);
    }

    public function like(Galery $galery)
    {
        $galery->likes()->updateOrCreate([
            'user_id' => auth()->id(),
        ]);

        return response()->json([
            'message' => 'Liked'
        ]);
    }

    public function unlike(Galery $galery)
    {
        $galery->likes()->where([
            'user_id' => auth()->id(),
        ])->delete();

        return response()->json([
            'message' => 'Unliked'
        ]);
    }
}
