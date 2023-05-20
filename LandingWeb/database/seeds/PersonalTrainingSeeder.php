<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PersonalTrainingSeeder extends Seeder
{
    /**
     * Run the database seeds.x
     *
     * @return void
     */
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        \Illuminate\Support\Facades\DB::table('personal_trainings')->truncate();
        \Illuminate\Support\Facades\DB::table('personal_trainings')->insert([
            [
                'id' => 1,
                'user_id' => 2,
                'name' => 'Phạm Văn Dung',
                'description' => 'Tập thể hình thay đổi chính bạn',
                'qualification' => 'Đại học thể dục thể thao tphcm',
                'experience' => 'Olympus gym, Green garden fitness center, Vinhomes central park',
                'image' => 'https://huonganhyoga.vn/Data/upload/images/Banner/fitness/ngoc-dung.png',
                'rating' => '80',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 2,
                'user_id' => 14,
                'name' => 'Nguyễn Văn Tư',
                'description' => 'PT Gym - PT Boxing, Kickboxing',
                'qualification' => 'Cử nhân chuyên ngành Huấn luyện viên Thể dục thể thao trường Đại học Thể dục Thể Thao TP.HCM, Huấn luyện viên Kickboxing quóc gia, Huấn luyện viên Võ cổ truyền, HCV Vô địch thế giới Võ cổ truyền 2018',
                'experience' => '3 năm',
                'image' => 'https://huonganhyoga.vn/Data/upload/images/Banner/fitness/65924059_270076713843517_153033129320251392_n.jpg',
                'rating' => '100',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 3,
                'user_id' => 14,
                'name' => 'Trần Khả Đạt',
                'description' => 'Kinh niệm 2 năm giảng dạy tại trung tâm và tự do. Giúp rất nhiều khách hàng đat đc mục tiêu. Tận tình và chuyên nghiệp',
                'qualification' => 'Chứng chỉ huấn luyện viên - Liên đoàn thể hình, Certificate of Nutrifort - American',
                'experience' => 'Personal trainer ( 12/2015 - 09/2018 )',
                'image' => 'https://2.bp.blogspot.com/-Z7zY0AKDqzQ/XCcIDB_yQMI/AAAAAAAACWA/f_Jo6REK6roxVqc6u3buMMXS57sefnewACLcBGAs/s1600/IMG_9899.jpg',
                'rating' => '50',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 4,
                'user_id' => 14,
                'name' => 'Harley Pasternak',
                'description' => 'Swimming, Personal trainer',
                'qualification' => 'Chứng nhận tham dự giải vô địch Châu Á trẻ, Chứng chỉ cứu hộ, Chứng chỉ huấn luyện viên bơi lội',
                'experience' => 'Swimming ( 12/2015 - 09/2018), Personal trainer ( 07/2015 - 09/2018 )',
                'image' => 'http://www.nshapefitness.vn/wp-content/uploads/2015/11/IMG_7473-crop-1.jpg',
                'rating' => '80',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 5,
                'user_id' => 14,
                'name' => 'Gunnar Peterson',
                'description' => 'Kinh niệm trên 18 năm giảng dạy tại trung tâm và tự do. Giúp rất nhiều khách hàng đat đc mục tiêu. Tận tình và chuyên nghiệp',
                'qualification' => 'Chứng nhận Huấn luyện viên MuayThai(hạng C) của liên đoàn World Muaythai Bangkok, Khóa đào tạo trọng tài muaythai toàn quốc, Khóa đào tạo HLV Thể lực do tiến sĩ William Sullivan cấp',
                'experience' => 'Boxing, Personal trainer(2002 - 09/2018 )',
                'image' => 'https://www.tigermuaythai.com/wp-core/wp-content/uploads/2016/03/tmt-trainer-kay-600x900.jpg',
                'rating' => '100',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 6,
                'user_id' => 14,
                'name' => 'Tracy Anderson',
                'description' => 'Bằng kinh nghiệm nhiều năm và sức trẻ của mình, tôi muốn dành tất cả thời gian cho bộ môn tôi yêu và hướng dẫn cho tất cả mọi người.',
                'qualification' => 'Chứng nhận huấn luyện viên thể hình fitness,đã dạy tại(California fitness, yoga center), PTX2,... ',
                'experience' => 'Personal trainer, yoga(07/2014 - 09/2018)',
                'image' => 'https://www.uaepersonaltrainers.com/wp-content/uploads/2017/04/dubai-ladies-female-personal-trainer-josephine.jpg',
                'rating' => '90',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 7,
                'user_id' => 14,
                'name' => 'Massy Arias',
                'description' => 'Yoga đến với tôi bằng sự đơn giản. Trả hóa cơ thể và tâm trí. Nắng lượng tích cực suy nghĩ lạc quan và lối sống lành mạnh. Chỉ cần bạn có nền tảng vững chắc mọi thứ sẽ trở nên dễ dàng hơn. Tôi được và bạn cũng sẽ được.',
                'qualification' => 'Chứng nhận Yoga Siromani, Yoga for children, huấn luyện viên yoga - liên đoàn yoga việt nam cấp',
                'experience' => 'Yoga ( 11/2017 - 09/2018 )',
                'image' => 'https://us.hola.com/images/0261-10668649c791-78fe521cfeaf-1000/vertical-800/massy-arias.png',
                'rating' => '95',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 8,
                'user_id' => 14,
                'name' => 'Bob Greene',
                'description' => 'PT kickboxing, MuayThai, Boxing, Gym',
                'qualification' => 'HCV môn Whusu năm 2016, HCV võ cổ truyền 2018, HCB vovinam 2017,...',
                'experience' => 'kickboxing, MuayThai, Boxing, Personal trainer ( 08/2011 - 09/2018 )',
                'image' => 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTG4sl4r6D3Q-nq_mMbVk68RK5cx6ZyngLQnxSzRJMrokczvYMDyQ',
                'rating' => '100',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 9,
                'user_id' => 14,
                'name' => 'Jennifer Widerstrom',
                'description' => 'no pain no gain',
                'qualification' => 'Chứng nhận huấn luyện viên thể hình -fitness, Huấn luyện viên thể hình liên đoàn cử tạ Việt Nam...',
                'experience' => 'personal trainer ( 01/2011 - 09/2018 )',
                'image' => 'https://static.onecms.io/wp-content/uploads/sites/12/2016/05/gettyimages-503674008-2000.jpg',
                'rating' => '100',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 10,
                'user_id' => 14,
                'name' => 'John Beradi',
                'description' => 'Giúp mọi người giảm cân và có body đẹp bằng boxing. Tập luyện vào sáng sớm trước 7h hoặc chiều tối từ 6h.',
                'qualification' => 'Chứng chỉ boxing liên đoàn boxing Việt Nam,huấn luyện viên kickboxing cấp quốc gia, HCV boxing 2017',
                'experience' => 'Boxing ( 12/2015 - 09/2018 )',
                'image' => 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPXdwsOLtuLt5GeKUle3iPoWZOP6LVOwCy3M7jOSb2UQJmMr42',
                'rating' => '80',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 11,
                'user_id' => 14,
                'name' => 'Katrina Scott',
                'description' => 'Tốt nghiệp hệ chính quy về thể thao của trường Đh TDTT. ĐÃ tốt nghiệp khóa đà tạo kĩ năng và nghiệp vu sư phạm về dạy bơi theo tiêu chuẩn quốc tế của Úc. Có nhiều năm kinh nghiệm dạy bơi cho trẻ e dưới 6 tuổi.',
                'qualification' => 'Chứng chỉ dạy bơi theo tiêu chuẩn của Úc, bằng an toàn dưới nước (CPR) AUSTSWIM',
                'experience' => 'Swimming ( 12/2015 - 09/2018 )',
                'image' => 'http://iptfitness.co.uk/wp-content/uploads/2015/03/aimee-personal-trainer-1.jpg',
                'rating' => '99,9',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 12,
                'user_id' => 14,
                'name' => 'Shawn Booth',
                'description' => 'Sức khỏe và thể hình là 2 yếu tố uan trọng trong cuốc sống. Và chọn được người huấn luyện viên phù hợp là yếu tố tiên quyết dẫn đến thành công. Tôi chính là lừa chọn đúng đăn của bạn.',
                'qualification' => 'Chứng chỉ huấn luyện viên cá nhân cấp quốc gia, Bằng cử nhân ngành giáo dục thể chất, bằng chứng nhận huấn luyện viên của INTERNATIONAL KETTLEBELL ASOCIATION',
                'experience' => 'personal trainer ( 12/2015 - 09/2018 )',
                'image' => 'https://victoria.mediaplanet.com/app/uploads/sites/112/2018/05/Shawn-Booth-576x486.jpg',
                'rating' => '100',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 13,
                'user_id' => 14,
                'name' => 'Scott Laider',
                'description' => 'Sức khỏe và thể hình là 2 yếu tố uan trọng trong cuốc sống. Và chọn được người huấn luyện viên phù hợp là yếu tố tiên quyết dẫn đến thành công. Tôi chính là lừa chọn đúng đăn của bạn.',
                'qualification' => 'Chứng chỉ huấn luyện viên cá nhân cấp quốc gia, Bằng cử nhân ngành giáo dục thể chất, bằng chứng nhận huấn luyện viên của INTERNATIONAL KETTLEBELL ASOCIATION',
                'experience' => 'personal trainer ( 12/2015 - 09/2018 )',
                'image' => 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRJX2PpJwl0Y2EU60lwWKb_BayKgUDsGRJh0YfaqImz9UTh-GST',
                'rating' => '70',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 14,
                'user_id' => 14,
                'name' => 'Miley Cirus',
                'description' => 'no pain no gain',
                'qualification' => 'Chứng nhận huấn luyện viên thể hình -fitness, Huấn luyện viên thể hình liên đoàn cử tạ Quốc Tế...',
                'experience' => 'personal trainer ( 01/2011 - 09/2018 )',
                'image' => 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRrWshFYD4ZZWl0IEYjKaRmAPidgZhICt1gK-gEpS3tg5P6_k5o',
                'rating' => '90',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 15,
                'user_id' => 14,
                'name' => 'Katy Anderson',
                'description' => 'Kinh niệm 10 năm giảng dạy tại trung tâm và tự do. Giúp rất nhiều khách hàng đat đc mục tiêu. Tận tình và chuyên nghiệp',
                'qualification' => 'Chứng nhận huấn luyện viên thể hình -fitness, Huấn luyện viên thể hình liên đoàn cử tạ Quốc Tế...',
                'experience' => 'personal trainer ,yoga( 01/2011 - 09/2018 )',
                'image' => 'https://media.gettyimages.com/photos/katy-perry-at-the-part-of-me-press-conference-at-the-four-seasons-on-picture-id146710767?s=612x612',
                'rating' => '90',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
        ]);
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');
    }
}
