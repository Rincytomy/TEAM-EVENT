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
        //post table rename to posts
        Schema::rename('post', 'posts');
        //gallery table rename to galleries
        Schema::rename('gallery', 'galleries');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //post table rename to posts
        Schema::rename('posts', 'post');
        //gallery table rename to galleries
        Schema::rename('galleries', 'gallery');
    }
};
