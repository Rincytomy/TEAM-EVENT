<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Post;

class PostController extends Controller
{

    public function index()
    {
        
        $posts = Post::with(['companies', 'galleries'])->where('user_id', auth()->user()->id)->orderBy('id', 'desc')->get();
        return response()->json($posts);
    }

    public function store(Request $request)
    {
        $post = Post::create($request->all());
        return response()->json($post);
    }


    public function show($id)
    {
        $post = Post::with('companies', 'galleries')->find($id);
        return response()->json($post);
    }


    public function update(Request $request, $id)
    {
        $post = Post::find($id);
        $post->update($request->all());
        return response()->json($post);
    }


    public function destroy($id)
    {
        $post = Post::find($id);
        $galleries = $post->galleries;
        foreach ($galleries as $gallery) {
            $gallery->delete();
        }
        $post->delete();
        return response()->json('deleted');
    }

 
    public function allPosts()
    {
        $posts = Post::with(['companies', 'galleries'])->get();
        return response()->json($posts);
    }
}
