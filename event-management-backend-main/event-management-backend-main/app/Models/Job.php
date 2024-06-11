<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Job extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function companies()
    {
        return $this->belongsTo(Company::class, 'company_id', 'id');
    }

    public $casts = [
        'is_active' => 'boolean',
        'is_filled' => 'boolean',
    ];

    public $hidden = [
        'updated_at',
    ];
}
