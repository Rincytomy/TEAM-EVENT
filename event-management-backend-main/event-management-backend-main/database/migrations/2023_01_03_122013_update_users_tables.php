<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

        Schema::table('users', function (Blueprint $table) {
            $table->string('address')->nullable();
            $table->string('dob');
            $table->enum('type', ['admin', 'manager', 'employee'])->default('employee');
            $table->boolean('is_verified')->default(false);
            $table->boolean('is_active')->default(true);
            $table->renameColumn('name', 'first_name');
            $table->string('last_name')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
};
