<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'first_name',
        'last_name',
        'email',
        'phone',
        'address',
        'dob',
        'password',
        'type',
        'is_verified',
        'is_active',
    ];


    protected $hidden = [
        'password',
        'remember_token',
        'email_verified_at',
        'updated_at',
    ];


    protected $casts = [
        'email_verified_at' => 'datetime',
        'is_verified' => 'boolean',
        'is_active' => 'boolean',
    ];

    public function companies()
    {
        return $this->hasOne(Company::class);
    }
}
