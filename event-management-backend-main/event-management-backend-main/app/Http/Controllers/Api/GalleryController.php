<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Gallery;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

class GalleryController extends Controller
{
    public function index()
    {
        $gallery = Gallery::all();
        return response()->json($gallery);
    }

    public function show($id)
    {
        $gallery = Gallery::find($id);
        return response()->json($gallery);
    }

    public function store(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'image' => 'required',
                'post_id' => 'required',
            ]);
            if ($validator->fails()) {
                $errors = $validator->errors();
                $errors = implode(" ", $errors->all());
                return response()->json([
                    'message' => $errors,
                ], 422);
            }
            if (file($request->image)) {
                $image = $request->file('image');
                $fileName = time() . '_' . $image->getClientOriginalName();
                $image = $image->storeAs('public/gallery', $fileName);
                $image = str_replace('public', '', $image);
                $gallery = Gallery::create([
                    'image' => $image,
                    'post_id' => $request->post_id,
                ]);
                return response()->json($gallery);
            
            }
        } catch (\Throwable $th) {
            Log::error($th->getMessage());
            return response()->json($th->getMessage(), 500);
        }
    }

    public function update(Request $request, $id)
    {
        $gallery = Gallery::find($id);
        $gallery->update($request->all());
        return response()->json($gallery);
    }

    public function destroy($id)
    {
        $gallery = Gallery::find($id);
        $gallery->delete();
        return response()->json('deleted');
    }
}
