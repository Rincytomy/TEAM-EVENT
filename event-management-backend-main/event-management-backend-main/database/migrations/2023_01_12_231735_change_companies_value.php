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
        Schema::table('companies', function (Blueprint $table) {
            $table->string('website')->nullable()->change();
            $table->string('logo')->nullable()->change();
            $table->string('cover_photo')->nullable()->change();
            $table->string('email')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('companies', function (Blueprint $table) {
            $table->string('website')->nullable(false)->change();
            $table->string('logo')->nullable(false)->change();
            $table->string('cover_photo')->nullable(false)->change();
            $table->string('email')->nullable(false)->change();
        });
    }
};
