<?php

namespace App\Http\Controllers\Api;


use Illuminate\Http\Request;
use App\Models\Company;
use App\Http\Controllers\Controller;

class CompanyController extends Controller
{
    public function index()
    {
        $companies = Company::all();
        return response()->json($companies);
    }

    public function show($id)
    {
        $company = Company::find($id);
        return response()->json($company);
    }

    public function store(Request $request)
    {
        $logo = null;
        $cover_photo = null;
        if ($request->file('logo')) {
            $fileName = time() . '_' . $request->file('logo')->getClientOriginalName();
            $logo = $request->file('logo')->storeAs('public/companies/logos', $fileName);
            $logo = str_replace('public', '', $logo);
        }
        if ($request->file('cover_photo')) {
            $fileName = time() . '_' . $request->file('cover_photo')->getClientOriginalName();
            $cover_photo = $request->file('cover_photo')->storeAs('public/companies/cover_photos', $fileName);
            $cover_photo = str_replace('public', '', $cover_photo);
        }

        $company = Company::create([
            'user_id' => $request->user_id,
            'name' => $request->name,
            'email' => $request->email,
            'website' => $request->website,
            'logo' => $logo,
            'cover_photo' => $cover_photo,
            'phone' => $request->phone,
            'address' => $request->address,
            'location' => $request->location,
        ]);
        return response()->json($company);
    }

    public function update(Request $request, $id)
    {
        $company = Company::find($id);
        $company->update($request->all());
        return response()->json($company);
    }

    public function destroy($id)
    {
        $company = Company::find($id);
        $company->delete();
        return response()->json('deleted');
    }
}
