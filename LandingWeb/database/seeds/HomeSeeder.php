<?php

use Illuminate\Database\Seeder;

class HomeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        \Illuminate\Support\Facades\DB::table('homes')->truncate();
        \Illuminate\Support\Facades\DB::table('homes')->insert([
            [
                'id' => 1,
                'title' => 'Tiết Kiệm Tiền',
                'description' => 'Nhiều hơn cho ít hơn',
                'content' => '<div class="row text-detail"> Đào tạo 1 kèm 1 với huấn luyện viên cá nhân trong phòng tập thể hình
                        hoặc
                        phòng thu rất tốn kém, đặc biệt nếu bạn muốn tập luyện nhiều hơn một lần một tuần để có kết quả
                        tối
                        ưu.
                        Một tháng đào tạo trực tuyến tốn ít hơn hai giờ đào tạo 1 kèm 1 với huấn luyện viên cá nhân
                        trung
                        bình.
                    </div>',
                'image' => 'image/pt.jpg',
                'status' => '1',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 2,
                'title' => 'Liên lạc 24/7',
                'description' => 'Ở đâu & khi nào bạn muốn!',
                'content' => '<div class="row text-detail"> Với một huấn luyện viên thường xuyên, bạn theo dõi khoảng 1-2 buổi đào
                        tạo
                        mỗi tuần.
                    </div>
                    <div class="row text-detail"> Đây là những khoảnh khắc liên lạc duy nhất mà bạn có thể hỏi tất cả
                        các
                        câu hỏi mà bạn đã chạy trong suốt cả tuần (nếu bạn không quên chúng).
                    </div>
                    <div class="row text-detail"> Và điều này cũng phải xảy ra trong khóa đào tạo của bạn, nơi sự chú ý
                        của
                        bạn thực sự nên tập trung vào chính khóa đào tạo đó.
                    </div>
                    <div class="row text-detail"> Với ứng dụng MY-PT, bạn có thể liên hệ với huấn luyện viên cá nhân của
                        mình và đặt câu hỏi bất cứ lúc nào. Bằng cách này bạn sẽ có được câu trả lời nhanh chóng cho tất
                        cả
                        các câu hỏi khẩn cấp của mình mà không phải chờ đến buổi đào tạo tiếp theo.
                    </div>',
                'image' => 'image/coms.jpg',
                'status' => '1',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 3,
                'title' => 'Chế độ ăn uống phù hợp',
                'description' => 'Không có giới hạn, ăn như thế nào bạn muốn.',
                'content' => '<div class="row text-detail"> Một kế hoạch ăn kiêng bao gồm 6 bữa cơm gà và rau mỗi ngày không thể
                        duy
                        trì.
                    </div>
                    <div class="row text-detail"> Điểm của lịch trình cho ăn là gì nếu bạn không thể gắn bó với nó trong
                        một
                        thời gian dài hơn?
                    </div>
                    <div class="row text-detail"> Tôi muốn bạn đạt được mục tiêu của mình và đó là lý do tại sao tôi
                        hoàn
                        toàn sắp xếp dinh dưỡng với bạn.
                    </div>
                    <div class="row text-detail"> Với kế hoạch dinh dưỡng "ăn thứ này và xem kết quả" chi tiết hoặc chế
                        độ
                        ăn "linh hoạt", phù hợp với loại cơ thể, mục tiêu và hoạt động hàng ngày của bạn, chúng tôi lập
                        kế
                        hoạch dinh dưỡng với các loại thực phẩm mà bạn thích!
                    </div>',
                'image' => 'image/communication.jpg',
                'status' => '1',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 4,
                'title' => 'Đào tạo khi nó phù hợp với bạn',
                'description' => 'Tôi nói với bạn như thế nào, bạn xác định khi nào.',
                'content' => '<div class="row text-detail"> Vì đào tạo cá nhân trực tuyến không phải là 1 trên 1 về địa điểm
                        , bạn có thể đào tạo khi nó phù hợp với bạn.
                    </div>
                    <div class="row text-detail"> Không có vấn đề với việc phối hợp lịch.
                    </div>
                    <div class="row text-detail">Bạn không trả tiền cho việc đào tạo mà bạn phải hủy vào phút cuối vì có
                        gì đó đã xảy ra.
                    </div>
                    <div class="row text-detail">Không vội vã từ công việc vì bạn phải nhanh chóng chuyển sang đào tạo,
                        nhưng tốt đẹp và yên tĩnh khi bạn muốn. Ngay cả khi bạn không muốn tập luyện trong phòng tập thể
                        dục, việc tập luyện có thể được điều chỉnh tại nhà.
                    </div>',
                'image' => 'image/traing.jpg',
                'status' => '1',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
        ]);
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');
    }
}