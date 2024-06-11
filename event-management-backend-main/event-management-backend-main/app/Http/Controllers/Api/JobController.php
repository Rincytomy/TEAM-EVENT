<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Job;

use Illuminate\Http\Request;

class JobController extends Controller
{
    public function index()
    {
        $jobs = Job::with('companies')->where('user_id', auth()->user()->id)->get();
        return response()->json($jobs);
    }

    public function show($id)
    {
        $job = Job::find($id);
        return response()->json($job);
    }

    public function store(Request $request)
    {
        $job = Job::create($request->all());
        return response()->json($job);
    }

    public function update(Request $request, $id)
    {
        $job = Job::find($id);
        $job->update($request->all());
        return response()->json($job);
    }

    public function destroy($id)
    {
        $job = Job::find($id);
        $job->delete();
        return response()->json('deleted');
    }

    public function allJobs()
    {
        $jobs = Job::with('companies')->get();
        return response()->json($jobs);
    }
}
