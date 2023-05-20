<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OrderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');

        \Illuminate\Support\Facades\DB::table('orders')->truncate();
        \Illuminate\Support\Facades\DB::table('orders')->insert([
            [
                'id' => 1,
                'user_id' => 1,
                'personal_training_id' => 1,
                'personal_training_time_id' => 1,
                'duration_id' => 2,

                'price' => 500000,
                'status' => 1,

                'created_at' => date('2019-08-22'),
                'updated_at' => date('2019-08-22')
            ],
            [
                'id' => 2,
                'user_id' => 1,
                'personal_training_id' => 1,
                'personal_training_time_id' => 2,
                'duration_id' => 4,

                'price' => 4000000,
                'status' => 1,

                'created_at' => date('2019-08-25'),
                'updated_at' => date('2019-08-25')
            ],
            [
                'id' => 3,
                'user_id' => 2,
                'personal_training_id' => 2,
                'personal_training_time_id' => 3,
                'duration_id' => 1,

                'price' => 200000,
                'status' => 1,

                'created_at' => date('2019-08-30'),
                'updated_at' => date('2019-08-30')
            ],
            [
                'id' => 4,
                'user_id' => 4,
                'personal_training_id' => 2,
                'personal_training_time_id' => 4,
                'duration_id' => 2,

                'price' => 500000,
                'status' => 1,

                'created_at' => date('2019-09-22'),
                'updated_at' => date('2019-09-22')
            ],
            [
                'id' => 5,
                'user_id' => 3,
                'personal_training_id' => 1,
                'personal_training_time_id' => 4,
                'duration_id' => 3,

                'price' => 400000,
                'status' => 1,

                'created_at' => date('2019-09-21'),
                'updated_at' => date('2019-09-21')
            ],
            [
                'id' => 6,
                'user_id' => 2,
                'personal_training_id' => 3,
                'personal_training_time_id' => 1,
                'duration_id' => 2,

                'price' => 500000,
                'status' => 1,

                'created_at' => date('2019-09-20'),
                'updated_at' => date('2019-09-20')
            ],
            [
                'id' => 7,
                'user_id' => 1,
                'personal_training_id' => 4,
                'personal_training_time_id' => 2,
                'duration_id' => 2,

                'price' => 600000,
                'status' => 1,

                'created_at' => date('2019-09-18'),
                'updated_at' => date('2019-09-18')
            ],
            [
                'id' => 8,
                'user_id' => 1,
                'personal_training_id' => 5,
                'personal_training_time_id' => 1,
                'duration_id' => 2,

                'price' => 200000,
                'status' => 1,

                'created_at' => date('2019-09-18'),
                'updated_at' => date('2019-09-18')
            ],
            [
                'id' => 9,
                'user_id' => 2,
                'personal_training_id' => 2,
                'personal_training_time_id' => 3,
                'duration_id' => 2,

                'price' => 500000,
                'status' => 1,

                'created_at' => date('2019-09-20'),
                'updated_at' => date('2019-09-20')
            ],
            [
                'id' => 10,
                'user_id' => 6,
                'personal_training_id' => 7,
                'personal_training_time_id' => 3,
                'duration_id' => 2,

                'price' => 2000000,
                'status' => 1,

                'created_at' => date('2019-09-17'),
                'updated_at' => date('2019-09-17')
            ],
            [
                'id' => 11,
                'user_id' => 4,
                'personal_training_id' => 8,
                'personal_training_time_id' => 2,
                'duration_id' => 2,

                'price' => 200000,
                'status' => 1,

                'created_at' => date('2019-09-22'),
                'updated_at' => date('2019-09-22')
            ],
            [
                'id' => 12,
                'user_id' => 4,
                'personal_training_id' => 7,
                'personal_training_time_id' => 2,
                'duration_id' => 2,
                'price' => 2000000,
                'status' => 1,

                'created_at' => date('2019-09-23'),
                'updated_at' => date('2019-09-23')
            ],
            [
                'id' => 13,
                'user_id' => 2,
                'personal_training_id' => 6,
                'personal_training_time_id' => 2,
                'duration_id' => 4,

                'price' => 4000000,
                'status' => 1,

                'created_at' => date('2019-09-25'),
                'updated_at' => date('2019-09-25')
            ],
        ]);
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');
    }

}
