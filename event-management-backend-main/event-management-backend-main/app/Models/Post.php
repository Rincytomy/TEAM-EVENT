<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function companies()
    {
        return $this->belongsTo(Company::class , 'company_id');
    }

    public function galleries()
    {
        return $this->hasMany(Gallery::class);
    }


    public $casts = [
        'is_active' => 'boolean',
    ];

    public $hidden = [
        'updated_at',
    ];
}
