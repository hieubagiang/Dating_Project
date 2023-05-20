<?php

use Illuminate\Database\Seeder;

class ReviewSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        \Illuminate\Support\Facades\DB::table('reviews')->truncate();
        \Illuminate\Support\Facades\DB::table('reviews')->insert([

            [
                'user_id' => 1,
                'personal_training_id' => 2,
                'rating' => '100',
                'review' => 'mình thể với các bạn là sự ra đời của trang web này quả là tuyệt với. Nó ko chỉ giải quyết vấn dề thực tế,… mà nó còn được thiết kế cực kì sáng tạo, sử dụng nó bất cứ khi nào bạn cần. Mình ưng thực sự luôn♥️♥️♥️n,',
                'status' => 1,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'user_id' => 2,
                'personal_training_id' => 1,
                'rating' => '100',
                'review' => 'Tôi đánh giá rất cao về chàng trai này',
                'status' => 1,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'user_id' => 4,
                'personal_training_id' => 1,
                'rating' => '100',
                'review' => 'Tôi sẽ quay lại thường xuyên',
                'status' => 1,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'user_id' => 3,
                'personal_training_id' => 2,
                'rating' => '100',
                'review' => 'Pt rất chuyên nghiệp ,chuyên môn tốt ',
                'status' => 1,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'user_id' => 6,
                'personal_training_id' => 1,
                'rating' => '100',
                'review' => 'Pt rất chuyên nghiệp  ',
                'status' => 0,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'user_id' => 7,
                'personal_training_id' => 2,
                'rating' => '100',
                'review' => 'HLV giỏi chuyên môn tốt  ',
                'status' => 0,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'user_id' => 8,
                'personal_training_id' => 1,
                'rating' => '60',
                'review' => 'Tôi đã tương đối hài lòng',
                'status' => 0,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]
        ]);
    }
}
