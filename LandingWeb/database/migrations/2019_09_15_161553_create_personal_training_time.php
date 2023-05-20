<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePersonalTrainingTime extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('personal_training_time', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('time_id')->unsigned()->index();
            $table->foreign('time_id')->references('id')->on('times')->onDelete('cascade');
            $table->unsignedBigInteger('personal_training_id')->unsigned()->index();
            $table->foreign('personal_training_id')->references('id')->on('personal_trainings')->onDelete('cascade');
            $table->integer('status')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('personal_training_time');
    }
}
