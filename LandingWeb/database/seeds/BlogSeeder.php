<?php

use Illuminate\Database\Seeder;

class BlogSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        DB::table('blogs')->truncate();
        DB::table('blogs')->insert([
            [
                'id' => 1,
                'thumbnail' => 'http://images.cfyc.com.vn/CFYC/t%E1%BA%ADp%20yoga%20%E1%BB%9F%20nh%C3%A0_697076269.jpg',
                'category' => 'Blog Yoga',
                'title' => '5 BÀI TẬP YOGA Ở NHÀ GIÚP DA CHẮC KHỎE VÀ RẠNG NGỜI',
                'detail' => 'Yoga face là một làn sóng mới trong công cuộc chăm sóc da thời hiện đại, đặc biệt là những bài tập Yoga ở nhà. Khi tập Yoga ở nhà các nàng vừa đáp ứng các tiêu chí tiết kiệm thời gian, tiền bạc nhưng vẫn đem lại hiệu quả đáng kể. Chúng ta cùng thử tham khảo 5 bài tập Yoga face cơ bản giúp da sáng khỏe, tinh thần tươi mới nhé!',
                'content' => '<p style="text-align: center;"><strong><em><img alt="Yoga face là bài tập yoga ở nhà bạn nên thực hiện để nâng cơ mặt" src="http://images.cfyc.com.vn/CFYC/t%E1%BA%ADp%20yoga%20%E1%BB%9F%20nh%C3%A0_486519154.jpg" style="width: 450px; height: 320px;" /></em></strong></p>

<p style="text-align: center;"><em>Yoga face l&agrave; một dạng tập Yoga ở nh&agrave; đơn giản, dễ thực hiện nhất nhưng đem lại hiệu quả kh&ocirc;ng hề nhỏ</em></p>

<p style="text-align: justify;">Yoga face l&agrave; một phương ph&aacute;p ho&agrave;n to&agrave;n tự nhi&ecirc;n gi&uacute;p chống l&atilde;o h&oacute;a, săn chắc cơ bắp v&agrave; l&agrave;m giảm vết nhăn. N&oacute; c&oacute; thể l&agrave;m thư gi&atilde;n khu&ocirc;n mặt, <a href="https://lifestyle.cfyc.com.vn/giam-beo-mat-3-cach-de-giam-thieu-chat-beo-kho-tri-tren-khuon-mat-p2d2497.html">giảm mỡ mặt</a>,&nbsp;gi&uacute;p n&acirc;ng cơ mặt một c&aacute;ch tự nhi&ecirc;n v&agrave; l&agrave;m dịu đi những biểu cảm căng thẳng m&agrave; ch&uacute;ng ta c&oacute; mỗi ng&agrave;y. Điều tuyệt vời hơn l&agrave; Yoga face c&oacute; thể l&agrave;m bất cứ nơi n&agrave;o, bất cứ l&uacute;c n&agrave;o m&agrave; bạn muốn.</p>

<h2 style="text-align: justify;"><strong>1.&nbsp;B&agrave;i tập yoga ở nhà&nbsp;h&ocirc;n gi&oacute; Marilyn</strong></h2>

<p style="text-align: justify;">B&agrave;i tập Yoga tại nh&agrave; n&agrave;y gi&uacute;p k&eacute;o c&aacute;c cơ ở v&ugrave;ng miệng. Khi thực hiện thường xuy&ecirc;n bạn sẽ thấy c&aacute;c đường n&eacute;t ở miệng săn chắc hơn, khu&ocirc;n miệng đẹp hơn v&agrave; v&ugrave;ng da quanh miệng kh&ocirc;ng bị chảy xệ.</p>

<p style="text-align: center;"><img alt="Tập yoga ở nhà với bài tập hôn gió Marilyn" src="http://images.cfyc.com.vn/CFYC/t%E1%BA%ADp%20yoga%20%E1%BB%9F%20nh%C3%A0_559708570.jpg" style="border-width: 0px; border-style: solid; width: 300px; height: 471px;" /></p>

<p style="text-align: center;"><em>B&agrave;i tập Yoga ở nh&agrave; tăng cường cơ m&ocirc;i</em></p>

<p style="text-align: justify;"><strong>C&aacute;ch thực hiện:</strong></p>

<ul>
	<li style="text-align: justify;">Động t&aacute;c chỉ đơn giản như những c&aacute;i h&ocirc;n gi&oacute;.</li>
	<li style="text-align: justify;">Bắt đầu chu m&ocirc;i như đang h&ocirc;n gi&oacute;</li>
	<li style="text-align: justify;">Cảm nhận cơ xung quanh m&ocirc;i v&agrave; m&aacute; căng hơn</li>
	<li style="text-align: justify;">Giữ động t&aacute;c trong v&ograve;ng 10 gi&acirc;y.</li>
</ul>

<p style="text-align: justify;">Lưu &yacute;: Lặp lại động t&aacute;c 4-5 lần mỗi ng&agrave;y.</p>

<h2 style="text-align: justify;"><strong>2.&nbsp;B&agrave;i tập yoga ở nhà Surprise me</strong></h2>

<p style="text-align: justify;">Đ&acirc;y l&agrave; b&agrave;i tập Yoga ở nh&agrave; gi&uacute;p chống những nếp nhăn từ những sự lo lắng v&agrave; giảm bớt vết ch&acirc;n chim hiện tr&ecirc;n mắt của bạn. Với bài t&acirc;̣p này, các cơ tr&ecirc;n mặt sẽ được di chuy&ecirc;̉n linh hoạt có tác dụng như vi&ecirc;̣c bạn massage mặt m&ocirc;̃i ngày.&nbsp;</p>

<p style="text-align: center;"><img alt="Tập yoga ở nhà với bài tập Surprise me" src="http://images.cfyc.com.vn/CFYC/t%E1%BA%ADp%20yoga%20%E1%BB%9F%20nh%C3%A0_521739787.jpg" style="border-width: 0px; border-style: solid; width: 450px; height: 332px;" /></p>

<p style="text-align: center;"><em>B&agrave;i tập Yoga ở nh&agrave; chống nhăn v&ugrave;ng tr&aacute;n</em></p>

<p style="text-align: justify;"><strong>C&aacute;ch thực hiện: </strong></p>

<ul>
	<li style="text-align: justify;">Nhướng v&ugrave;ng ch&acirc;n m&agrave;y - tr&aacute;n l&ecirc;n tr&ecirc;n.</li>
	<li style="text-align: justify;">Mắt nh&igrave;n thẳng v&agrave;o một điểm trong 5 gi&acirc;y.</li>
	<li style="text-align: justify;">Sau đ&oacute; thả cơ mặt về lại b&igrave;nh thường</li>
</ul>

<p style="text-align: justify;">Lưu &yacute;: Lặp lại 3-4 lần mỗi ng&agrave;y.</p>

<h2 style="text-align: justify;"><strong>3.&nbsp;B&agrave;i tập yoga ở nhà Smiling Fish Face</strong></h2>

<p style="text-align: justify;">Đ&acirc;y được coi như một chất tăng cường săn chắc cơ m&ocirc;i v&agrave; m&aacute; trong số c&aacute;c b&agrave;i tập Yoga ở nh&agrave;. N&ecirc;́u thực hi&ecirc;̣n thường xuy&ecirc;n, các bạn sẽ hạn ch&ecirc;́ được vi&ecirc;̣c xu&acirc;́t hi&ecirc;̣n các n&ecirc;́p nhăn ở khóe mi&ecirc;̣ng. Bài t&acirc;̣p yoga ở nhà này có tác dụng như vi&ecirc;̣c bạn <a href="https://lifestyle.cfyc.com.vn/hoc-nguoi-nhat-3-dong-tac-matxa-sieu-de-de-tang-kich-thuoc-vong-1-p2d1331.html">massage</a> cho mặt m&ocirc;̃i ngày, th&ecirc;́ n&ecirc;n, còn ch&acirc;̀n chứ gì mà kh&ocirc;ng bỏ ra m&ocirc;̃i ngày vài phút thực hi&ecirc;̣n nhỉ?</p>

<p style="text-align: center;"><img alt="Tập Yoga ở nhà với bài tập Smiling Fish Face" src="http://images.cfyc.com.vn/CFYC/t%E1%BA%ADp%20yoga%20%E1%BB%9F%20nh%C3%A0_697076269.jpg" style="border-width: 0px; border-style: solid; width: 450px; height: 320px;" /></p>

<p style="text-align: center;"><em>B&agrave;i tập Yoga ở nh&agrave; tăng cường cơ m&ocirc;i v&agrave; cơ m&aacute;</em></p>

<p style="text-align: justify;"><strong>C&aacute;ch thực hiện:</strong></p>

<ul>
	<li style="text-align: justify;">Đầu ti&ecirc;n, chu m&ocirc;i v&agrave; h&oacute;p m&aacute; th&agrave;nh hai lỗ h&otilde;m hai b&ecirc;n như khu&ocirc;n mặt của một con c&aacute;.</li>
	<li style="text-align: justify;">Giữ động t&aacute;c n&agrave;y trong v&ograve;ng 5 gi&acirc;y.</li>
</ul>

<p style="text-align: justify;">Lưu &yacute;: Để đạt được hiệu quả tốt nhất n&ecirc;n lặp lại 4-5 lần mỗi ng&agrave;y.</p>

<h2 style="text-align: justify;"><strong>4.&nbsp;B&agrave;i tập yoga ở nhà&nbsp;Bumblebee</strong></h2>

<p style="text-align: justify;">Tác dụng của bài t&acirc;̣p yoga ở nhà này là giúp cho các cơ tr&ecirc;n mặt được di chuy&ecirc;̉n thường xuy&ecirc;n, hạn ch&ecirc;́ tình trạng các cơ bị đơ theo thời gian. Thực hi&ecirc;̣n bi&ecirc;̉u cảm này thường xuy&ecirc;n tr&ecirc;n mặt sẽ giúp bạn giảm được các n&ecirc;́p nhăn khi bước vào tu&ocirc;̉i trung ni&ecirc;n.&nbsp;</p>

<p style="text-align: justify;"><strong>C&aacute;ch thực hiện:</strong></p>

<ul>
	<li style="text-align: justify;">Đầu ti&ecirc;n h&iacute;t thật s&acirc;u v&agrave;o.</li>
	<li style="text-align: justify;">Sau đ&oacute; l&agrave;m phẳng cơ m&ocirc;i của bạn trong khi thở ra v&agrave; ng&acirc;n nga &ldquo;Hmm&rdquo;.</li>
</ul>

<p style="text-align: justify;">Lưu &yacute;: Lặp lại b&agrave;i tập n&agrave;y 4-5 lần mỗi ng&agrave;y để c&oacute; được hiệu quả tốt nhất.</p>

<p style="text-align: center;"><img alt="Tập Yoga ở nhà với bài tập Bumblebee" src="http://images.cfyc.com.vn/CFYC/t%C3%A2%CC%A3p%20yoga%20%C6%A1%CC%89%20nha%CC%80_757888390.jpg" style="border-width: 0px; border-style: solid; width: 374px; height: 320px;" /></p>

<p style="text-align: center;"><em>B&agrave;i tập Yoga ở nh&agrave; thư gi&atilde;n v&agrave; săn chắc cơ m&ocirc;i</em></p>

<h2 style="text-align: justify;"><strong>5.&nbsp;Tập yoga ở nhà với bài t&acirc;̣p&nbsp;phồng m&aacute;</strong></h2>

<p style="text-align: justify;">Theo thời gian, các cơ tr&ecirc;n mặt n&ecirc;́u kh&ocirc;ng thường xuy&ecirc;n dịch chuy&ecirc;̉n sẽ khi&ecirc;́n mặt bạn d&ecirc;̃ bị tình trạng đơ. Bi&ecirc;̉u cảm ph&ocirc;̀ng má là bài tập Yoga ở nh&agrave; d&agrave;nh cho cơ m&aacute; v&agrave; cơ h&agrave;m gi&uacute;p cho cơ m&aacute; săn chắc hơn v&agrave; kh&ocirc;ng bị chảy xệ. Bài t&acirc;̣p n&agrave;y&nbsp;có th&ecirc;̉ thay th&ecirc;́ vi&ecirc;̣c massage mặt m&ocirc;̃i ngày nhưng v&acirc;̃n đảm bảo hi&ecirc;̣u quả v&ecirc;̀ vi&ecirc;̣c n&acirc;ng cơ và tránh lão hóa da mặt.&nbsp;</p>

<p style="text-align: justify;"><strong>C&aacute;ch thực hiện:</strong></p>

<ul>
	<li style="text-align: justify;">Đầu ti&ecirc;n phồng m&aacute; thật căng v&agrave; giữ hơi b&ecirc;n trong khoang miệng.</li>
	<li style="text-align: justify;">Sau đ&oacute; đưa từ b&ecirc;n n&agrave;y sang b&ecirc;n kia như đang s&uacute;c miệng.</li>
</ul>

<p style="text-align: justify;">Lưu &yacute;: Thực hiện mỗi b&ecirc;n 8 lần mỗi ng&agrave;y.</p>

<p style="text-align: center;"><img alt="Tập Yoga ở nhà với bài tập Phồng má" src="http://images.cfyc.com.vn/CFYC/t%E1%BA%ADp%20yoga%20%E1%BB%9F%20nh%C3%A0_290016221.jpg" style="border-width: 0px; border-style: solid; width: 450px; height: 320px;" /></p>

<p style="text-align: center;"><em>B&agrave;i tập Yoga ở nh&agrave; d&agrave;nh cho cơ m&aacute;</em></p>

<h2 style="text-align: justify;"><strong>6.&nbsp;Chăm s&oacute;c da sau khi luy&ecirc;̣n&nbsp;tập yoga ở nhà</strong></h2>

<p style="text-align: justify;">Sau khi trải qua những b&agrave;i <a href="https://lifestyle.cfyc.com.vn/4-tu-the-yoga-co-ban-cho-nguoi-moi-bat-dau-p2d296.html">luyện tập Yoga</a> ở nh&agrave; th&igrave; kh&acirc;u quan trọng kh&ocirc;ng k&eacute;m ch&iacute;nh l&agrave; chăm s&oacute;c, dưỡng da. Trong t&igrave;nh trạng lỗ ch&acirc;n l&ocirc;ng đang nở to v&igrave; mồ h&ocirc;i tiết ra, bạn n&ecirc;n để mặt r&aacute;o mồ h&ocirc;i, rửa mặt bằng nước lạnh. Khi rửa kh&ocirc;ng d&ugrave;ng qu&aacute; nhiều lực v&agrave;o l&uacute;c n&agrave;y v&igrave; sau khi tự tập Yoga ở nh&agrave;, m&aacute;u bơm về da kh&aacute; nhiều n&ecirc;n da hiện rất nhạy cảm, dễ g&acirc;y tổn thương nhẹ tới da.</p>

<p style="text-align: center;"><img alt="Chăm sóc da sau khi tập yoga ở nhà" src="http://images.cfyc.com.vn/CFYC/t%E1%BA%ADp%20yoga%20%E1%BB%9F%20nh%C3%A0_1006653784.jpg" style="border-width: 0px; border-style: solid; width: 450px; height: 320px;" /></p>

<p style="text-align: center;"><em>Chăm s&oacute;c da mặt sau c&aacute;c b&agrave;i tập Yoga ở nh&agrave; l&agrave; điều quan trọng kh&ocirc;ng k&eacute;m c&aacute;c b&agrave;i tập Yoga face</em></p>

<p style="text-align: justify;">Ngo&agrave;i ra, c&aacute;c biện ph&aacute;p như sử dụng c&aacute;c chất l&agrave;m dịu da như calendula, arnica v&agrave; bột yến mạch, mặt nạ dịu nhẹ, bổ sung c&aacute;c loại tr&aacute;i c&acirc;y cũng như vitamin hay chất xơ đều cần thiết để gi&uacute;p l&agrave;n da th&ecirc;m s&aacute;ng khỏe, tinh thần tươi mới!</p>

<p style="text-align: justify;"><br />
Những b&agrave;i tập Yoga ở nh&agrave; cực kỳ đơn giản v&agrave; kh&ocirc;ng mất qu&aacute; nhiều thời gian phải kh&ocirc;ng n&agrave;o? Chỉ cần l&agrave;m theo đ&uacute;ng c&aacute;c động t&aacute;c kết hợp chăm s&oacute;c da đ&uacute;ng c&aacute;ch th&igrave; chuyện c&oacute; một &ldquo;l&agrave;n da kh&ocirc;ng tuổi&rdquo; chỉ l&agrave; điều sớm muộn. Vậy n&ecirc;n c&ograve;n chần chừ g&igrave; nữa m&agrave; kh&ocirc;ng bắt tay ngay thực hiện c&aacute;c b&agrave;i tập Yoga ngay th&ocirc;i! H&atilde;y c&ugrave;ng t&igrave;m hiểu th&ecirc;m c&aacute;c b&agrave;i tập Yoga ở nh&agrave; tại CFYC. N&ecirc;́u bạn v&acirc;̃n còn thắc mắc v&ecirc;̀ các bài t&acirc;̣p th&ecirc;̉ hình, hãy li&ecirc;n h&ecirc;̣ với CFYC đ&ecirc;̉ dược đ&ocirc;̣i ngũ chuy&ecirc;n vi&ecirc;n tư v&acirc;́n và giải đáp cụ th&ecirc;̉ nhé!</p>
',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            array(
                'id' => 2,
                'thumbnail' => 'http://images.cfyc.com.vn/Jun%20Bui/Recap%20CMG%20AWARD%202018/randy-phat-bieu.png',
                'category' => 'Blog Yoga',
                'title' => '“MY CLUB – MY ADDICTION” GÓP PHẦN ĐỊNH HÌNH LẠI HÀNH VI “NGHIỆN”',
                'detail' => 'Nhiều người Việt Nam đang chọn lựa “nghiện” những thứ gây hại đến sức khỏe, nguyên nhân gây nên ung thư như dung nạp nhiều rượu bia, chất kích thích… “My Club – My Addiction” góp phần định hình lại hành vi “nghiện”. Bạn vẫn hoàn toàn “nghiện” những thứ mang lại lợi ích cho sức khỏe.',
                'content' => '<p>C&oacute; ba chứng nghiện phổ biến g&acirc;y n&ecirc;n ba căn bệnh ung thư h&agrave;ng đầu hiện nay l&agrave; nghiện h&uacute;t thuốc g&acirc;y ung thư phổi, nghiện uống rượu bia dẫn đến ung thư gan v&agrave; ăn sản phẩm kh&ocirc;ng tốt t&aacute;c động xấu l&ecirc;n dạ d&agrave;y.&nbsp;Theo một nghi&ecirc;n cứu gần đ&acirc;y về ph&ograve;ng chống ung thư, một tam gi&aacute;c ph&ograve;ng chống ung thư hiệu quả c&oacute; thể gi&uacute;p giảm nguy cơ mắc căn bệnh n&agrave;y đến 30% nếu thực hiện đều đặn. Thứ nhất l&agrave; tập thể dục thường xuy&ecirc;n, thứ hai l&agrave; ăn uống khoa học, thứ ba l&agrave; kiểm so&aacute;t c&acirc;n nặng.</p>

<p style="text-align: center;"><iframe allow="autoplay; encrypted-media" allowfullscreen="" frameborder="0" height="350" src="https://www.youtube.com/embed/VNigT7Rua_8" width="620"></iframe></p>

<p><em>Với những điều nghi&ecirc;n cứu được như tr&ecirc;n, tập đo&agrave;n CMG.ASIA kh&ocirc;ng ngừng tập trung v&agrave;o c&aacute;c hoạt động tạo ra sự nhận thức tới người d&acirc;n Việt Nam trong việc n&acirc;ng cao sức đề kh&aacute;ng cho cơ thể bằng c&aacute;c hoạt động thể chất lẫn tinh thần thiết thực tại c&aacute;c c&acirc;u lạc bộ của tập đo&agrave;n như sau:</em></p>

<p><strong>1. </strong>H&igrave;nh th&agrave;nh quỹ CMG Family Cancer Foundation &ndash; Quỹ hỗ trợ c&aacute;c bệnh nh&acirc;n ung thư, đặc biệt l&agrave; trẻ em v&agrave; người th&acirc;n của họ. Tất c&aacute;c c&aacute;c doanh thu c&oacute; được trong hoạt động kinh doanh của tập đo&agrave;n CMG.ASIA&nbsp;sẽ được tr&iacute;ch một phần l&agrave;m chi ph&iacute; hoạt động cho quỹ n&agrave;y.</p>

<p style="text-align: center;"><iframe allow="encrypted-media" allowfullscreen="true" allowtransparency="true" frameborder="0" height="574" scrolling="no" src="https://www.facebook.com/plugins/video.php?href=https%3A%2F%2Fwww.facebook.com%2FRandyG.Dobson%2Fvideos%2F2280980648800277%2F&amp;show_text=1&amp;width=560" style="border:none;overflow:hidden" width="620"></iframe></p>

<p><strong>T&igrave;m hiểu th&ecirc;m:&nbsp;<a href="https://lifestyle.cfyc.com.vn/cach-phong-chong-cac-loai-benh-ung-thu-pho-bien-moi-nguoi-nen-biet-de-tu-cuu-minh-p2d2678.html" target="_blank">C&Aacute;CH PH&Ograve;NG CHỐNG C&Aacute;C LOẠI BỆNH UNG THƯ PHỔ BIẾN MỌI NGƯỜI N&Ecirc;N BIẾT ĐỂ TỰ CỨU M&Igrave;NH</a></strong></p>

<p><strong>2.</strong> Triển l&atilde;m Tăng cường chất lượng sống LEEP ASIA diễn ra v&agrave;o trung tuần th&aacute;ng 8 vừa&nbsp;qua cũng nằm trong kh&aacute;t vọng tăng cường nhận thức của người d&acirc;n Việt Nam về căn bệnh ung thư.<em> &ldquo;LEEP ASIA được t&ocirc;i kỳ vọng như một c&uacute; h&iacute;ch truyền th&ocirc;ng t&aacute;c động đến t&acirc;m l&yacute; của mọi người Việt Nam rằng nghiện tập luyện thể thao sẽ gi&uacute;p ch&uacute;ng ta sống khỏe hơn&rdquo;</em>, &ocirc;ng Randy Dobson - Chủ tịch CMG.ASIA quan niệm.</p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20CMG%20AWARD%202018/randy-phat-bieu.png" style="width: 600px; height: 401px;" /></p>

<p><strong>T&igrave;m hiểu th&ecirc;m:&nbsp;<a href="https://lifestyle.cfyc.com.vn/nhung-khoanh-khac-an-tuong-cac-con-so-dang-nho-tai-leep-asia-2018-p2d2705.html" target="_blank">NHỮNG KHOẢNH KHẮC ẤN TƯỢNG &amp; C&Aacute;C CON SỐ Đ&Aacute;NG NHỚ TẠI LEEP ASIA 2018</a></strong></p>

<p><strong>3. </strong>Trong th&aacute;ng 9/2018, tập đo&agrave;n CMG.ASIA giới thiệu chương tr&igrave;nh BTC21 - Body Transformation Challenge nhằm mong muốn tạo động lực cho&nbsp;hội vi&ecirc;n v&agrave; kh&aacute;ch h&agrave;ng thay đổi diện mạo bản th&acirc;n một c&aacute;ch t&iacute;ch cực th&ocirc;ng qua việc cải thiện c&aacute;c chỉ số h&igrave;nh thể: tăng cơ, giảm mỡ. Việc kiểm so&aacute;t c&acirc;n nặng v&agrave; sở hữu một cơ thể c&acirc;n đối g&oacute;p phần tạo dựng một sức khỏe tốt v&agrave; bền vững, ph&ograve;ng chống c&aacute;c loại bệnh tật, bao gồm c&aacute;c loại bệnh ung thư&nbsp;nguy hiểm.</p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/0%20Calipso_Gina/My-club-my-addiction/BTC%20Body%20Transformation%20Challenge%2021%20-%20California%20Fitness%20Yoga%20Center.jpg" style="width: 620px; height: 348px;" /></p>

<p>4. Cũng<strong> t</strong>rong th&aacute;ng 9/2018, tập đo&agrave;n CMG.ASIA giới thiệu chiến dịch Move 21; thử th&aacute;ch bản th&acirc;n v&agrave; bạn b&egrave; trong 21 ng&agrave;y li&ecirc;n tiếp. 21 ng&agrave;y tạo th&agrave;nh&nbsp;th&oacute;i quen, từ đ&oacute; gi&uacute;p cơ thể&nbsp;duy tr&igrave; việc tập thể dục v&agrave; lối sống năng động -&nbsp;một nh&acirc;n tố g&oacute;p phần ph&ograve;ng ngừa v&agrave; giảm thiểu nguy cơ mắc bệnh ung thư. Sau 21 ng&agrave;y, tập đo&agrave;n sẽ gi&uacute;p&nbsp;mỗi&nbsp;hội vi&ecirc;n quy&ecirc;n g&oacute;p 210.000 đồng v&agrave;o quỹ&nbsp;CMG Family Cancer Foundation.</p>

<p style="text-align: center;"><iframe allow="autoplay; encrypted-media" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/tvqOW5KB0mk" width="560"></iframe></p>

<p><strong>5.</strong> V&agrave;o ng&agrave;y lễ Noel 2018 năm nay, CMG.ASIA cũng sẽ tổ chức hoạt động Xmas Giving Tree. Đ&acirc;y l&agrave; hoạt động thường ni&ecirc;n hướng đến kết nối c&aacute;c th&agrave;nh vi&ecirc;n, hội vi&ecirc;n của CMG.ASIA c&ugrave;ng chung tay gi&uacute;p đỡ trẻ em. Năm nay, chương tr&igrave;nh sẽ&nbsp;hướng đến những bệnh nhi đang điều trị bệnh ung thư.</p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/upload/Lifestyle%20website%20article/Exercise/Pyn/Pyn2/CGT%20%286%29.JPG" style="width: 500px; height: 750px;" /></p>

<p><strong>6. </strong>Ngo&agrave;i ra, tập đo&agrave;n cũng kh&ocirc;ng ngừng truyền đi th&ocirc;ng điệp mạnh mẽ tới cộng đồng: <em>&quot;Nghiện luyện tập để ph&ograve;ng chống bệnh ung thư&quot;&nbsp;&nbsp;</em>được rất nhiều&nbsp;b&aacute;o đ&agrave;i ủng hộ v&agrave; chia sẻ, c&oacute; thể kể đến như:<strong>&nbsp;<a href="https://nhipcaudautu.vn/su-kien-doanh-nghiep/chu-tich-cmgasia-randy-dobson-nghien-luyen-tap-gop-phan-day-lui-ung-thu-3325701/" target="_blank">Nhịp cầu đầu tư</a>,&nbsp;<a href="https://nudoanhnhan.net/leep-asia-2018-khang-dinh-vai-tro-dan-dau-trong-tang-cuong-chat-luong-song.html" target="_blank">Nữ doanh nh&acirc;n</a>,&nbsp;<a href="http://yeah1.com/doi-song/cmg-asia-tiep-tuc-dan-dau-nganh-cong-nghiep-tang-cuong-chat-luong-song-1.html" target="_blank">Yeah 1</a>,&nbsp;<a href="https://www.facebook.com/tintucvtv9/videos/669541636760835/" target="_blank">VTV9</a>,&nbsp;<a href="http://kenh14.vn/yaya-truong-nhi-dau-muay-thai-gay-quy-ho-tro-benh-nhan-ung-thu-20180820161255671.chn" target="_blank">K&ecirc;nh 14</a>,&nbsp;<a href="http://thegioivanhoa.net/su-kien-yoga-for-life-cua-ho-ngoc-ha-chay-tham-11684.html" target="_blank">Thế giới văn h&oacute;a</a>,&nbsp;...</strong></p>

<p style="text-align: center;"><strong><img alt="" src="http://images.cfyc.com.vn/0%20Calipso_Gina/My-club-my-addiction/my-club-my-addiction%20thong%20diep%20ve%20viec%20nghien%20tich%20cuc.jpg" style="width: 620px; height: 413px;" /></strong></p>

<p><strong>V&agrave; rất nhiều hoạt động kh&aacute;c hứa hẹn sẽ b&ugrave;ng nổ trong năm 2019</strong></p>

<p><em>Tập đo&agrave;n CMG.ASIA hiện c&oacute; hơn 30 c&acirc;u lạc bộ thể dục thể h&igrave;nh v&agrave; chăm s&oacute;c sức khỏe tr&ecirc;n cả nước. Sau 10 năm c&oacute; mặt tại Việt Nam, CMG.ASIA đ&atilde; ph&aacute;t triển mở rộng th&agrave;nh một hệ sinh th&aacute;i Tăng cường chất lượng sống (LEEP) với 4 lĩnh vực l&agrave; California Management Group (lĩnh vực thể h&igrave;nh), California Medical Group (lĩnh vực sức khỏe v&agrave; l&agrave;m đẹp), California Media Group (lĩnh vực quảng c&aacute;o, truyền th&ocirc;ng kĩ thuật số, film v&agrave; truyền h&igrave;nh) v&agrave; Retail &ndash; Distribution, lĩnh vực b&aacute;n lẻ v&agrave; thời trang. Bốn lĩnh vực n&agrave;y đang sở hữu 18 thương hiệu bao gồm: California Fitness &amp; Yoga Center, UFC Vietnam, Yoga Plus, CaliKids Academy, Centuryon, Eri International, Yeah1!CMG, CA Active...</em></p>
',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ),
            [
                'id' => 3,
                'thumbnail' => 'http://www.yogaplus.vn/storage/app/uploads/public/5b5/a95/5dd/thumb_1687_800x500_0_0_crop.jpg',
                'category' => 'Blog Yoga',
                'title' => 'HỒ NGỌC HÀ: “LẦN ĐẦU TIÊN SAU 10 NĂM, HÀ ĐỨNG TRÊN SÂN KHẤU HƯỚNG DẪN YOGA CHO MỌI NGƯỜI”',
                'detail' => 'Hồ Ngọc Hà, nữ ca sĩ với sự gắn bó và đam mê với bộ môn Yoga nhiều năm, sẽ cùng các tín đồ Yoga tham dự sự kiện Yoga for Life tại LEEP ASIA 2018. Ngoài ra, cô còn tham gia trình diễn tại CMG.ASIA Fitness & Entertaiment Awards. Nữ hoàng giải trí đã gửi lời mời để các hội viên cùng cô tham dự các sự kiện năm nay.',
                'content' => ' <p style="text-align: center;"><iframe allow="autoplay; encrypted-media" allowfullscreen="" frameborder="0" height="460" src="https://www.youtube.com/embed/lkhg0yMcqR0" width="666"></iframe></p>

<p><em>&quot;Xin ch&agrave;o tất cả c&aacute;c bạn, hiện H&agrave; đang c&oacute; mặt tại Trung t&acirc;m Centuryon v&agrave; h&ocirc;m nay H&agrave; rất mong muốn chia sẻ lịch tr&igrave;nh của bản th&acirc;n. V&agrave;o ng&agrave;y 16 v&agrave; ng&agrave;y 17 th&aacute;ng 08 năm 2018, H&agrave; sẽ tham dự Triển l&atilde;m tăng cường chất lượng sống &ndash; LEEP ASIA 2018. Tối ng&agrave;y 16/08, H&agrave; sẽ tham dự v&agrave;o phần tr&igrave;nh diễn tại buổi lễ trao giải CMG.ASIA Fitness &amp; Entertainment Awards. V&agrave; s&aacute;ng 17/08, H&agrave; sẽ tham dự việc tập luyện Yoga v&agrave; rất mong muốn tất cả c&aacute;c bạn khi được biết đến th&ocirc;ng tin th&igrave; h&atilde;y c&ugrave;ng đến. Đ&acirc;y l&agrave; lần đầu ti&ecirc;n sau 10 năm tập luyện Yoga, H&agrave; đứng tr&ecirc;n s&acirc;n khấu để c&oacute; thể chia sẻ những b&iacute; quyết, c&ugrave;ng tập luyện v&agrave; hướng dẫn&nbsp;mọi người. Ngo&agrave;i ra, chương tr&igrave;nh n&agrave;y c&ograve;n g&acirc;y Quỹ để ủng hộ c&aacute;c bệnh nh&acirc;n Ung thư. Rất mong c&aacute;c bạn sẽ đến nh&agrave; thi đấu Nguyễn Du v&agrave; c&ugrave;ng tập luyện với H&agrave; nh&eacute;: -&nbsp;</em><strong>Hồ Ngọc H&agrave; chia sẻ.</strong></p>

<p style="text-align: center;"><iframe allow="encrypted-media" allowtransparency="true" frameborder="0" height="700" scrolling="no" src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2Fhongocha%2Fposts%2F2103995166277434&amp;width=620" style="border:none;overflow:hidden" width="620"></iframe></p>

<p style="text-align: center;"><img src="http://images.cfyc.com.vn/Jun%20Bui/khai%20tr%C6%B0%C6%A1ng%20landmark%2081/ho-ngoc-ha-landmark81.png" /></p>

<h3 style="text-align: justify;"><strong>Lễ trao giải CMG.ASIA&nbsp;Fitness and Entertainment Awards đầy s&ocirc;i động v&agrave; m&agrave;u sắc</strong></h3>

<p style="text-align: justify;">CMG.ASIA&nbsp;Fitness and Entertainment Awards l&agrave; giải thưởng thường ni&ecirc;n uy t&iacute;n của tập đo&agrave;n CMG.ASIA&nbsp;&ndash; vinh danh những nh&acirc;n vật c&oacute; th&agrave;nh tựu nổi bật trong c&aacute;c lĩnh vực giải tr&iacute;, thể thao v&agrave; thể h&igrave;nh, g&oacute;p phần truyền cảm hứng &ldquo;l&agrave;m cho cuộc sống tốt đẹp hơn&rdquo; đến cộng đồng.</p>

<p style="text-align: center;"><iframe allow="autoplay; encrypted-media" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/f9ETnxfzmt8" width="560"></iframe></p>

<p style="text-align: justify;">B&ecirc;n cạnh c&aacute;c phần trao giải thưởng&nbsp;c&ograve;n c&oacute; c&aacute;c tiết mục văn nghệ đặc sắc với sự tham dự của c&aacute;c ng&ocirc;i sao h&agrave;ng đầu Showbiz như: Hồ Ngọc H&agrave;, Thu Minh, c&ugrave;ng c&aacute;c tiết mục ấn tượng như tr&igrave;nh diễn thời trang v&agrave; nhảy đ&egrave;n LED.</p>

<p style="text-align: justify;">T&igrave;m hiểu th&ecirc;m:&nbsp;<a href="https://lifestyle.cfyc.com.vn/ban-biet-gi-ve-cac-hoat-dong-se-dien-ra-tai-leep-asia-2018-p2d2617.html" target="_blank"><strong>BẠN BIẾT G&Igrave; VỀ C&Aacute;C HOẠT ĐỘNG SẼ DIỄN RA TẠI LEEP ASIA 2018?</strong></a></p>

<h3 style="text-align: justify;"><strong>Yoga For Life&nbsp;&ndash; Luyện tập Yoga c&ugrave;ng c&aacute;c bệnh nh&acirc;n Ung thư</strong></h3>

<p style="text-align: justify;">Năm nay, LEEP ASIA 2018 sẽ c&oacute; th&ecirc;m chương tr&igrave;nh tập Yoga tập thể với c&aacute;c bậc thầy h&agrave;ng đầu Việt Nam v&agrave; đặc biệt l&agrave; c&oacute; sự tham gia của ca sĩ Hồ Ngọc H&agrave;.&nbsp;Tại sự kiện n&agrave;y, bạn sẽ được giao lưu với&nbsp; rất nhiều người c&oacute; niềm đam m&ecirc; chung, đồng thời biết th&ecirc;m nhiều động t&aacute;c mới v&agrave; c&aacute;ch tập luyện đ&uacute;ng c&aacute;ch.</p>

<p style="text-align: center;"><iframe allow="autoplay; encrypted-media" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/-nqunnplO8c" width="560"></iframe></p>

<p style="text-align: justify;">T&igrave;m hiểu th&ecirc;m:&nbsp;<a href="https://lifestyle.cfyc.com.vn/cung-ho-ngoc-ha-tham-du-su-kien-yoga-for-life-tai-leep-asia-2018-p2d2633.html" target="_blank"><strong>C&Ugrave;NG HỒ NGỌC H&Agrave; THAM DỰ SỰ KIỆN YOGA FOR LIFE TẠI LEEP ASIA 2018</strong></a></p>

<p style="text-align: justify;"><em><strong>Tập đo&agrave;n CMG.ASIA xin cảm ơn c&aacute;c nh&agrave; t&agrave;i trợ&nbsp;Oriflame, S&agrave;i G&ograve;n Tiếp Thị, &nbsp;NhacCuaTui v&agrave;&nbsp;BenStyle đ&atilde; hỗ trợ ch&uacute;ng t&ocirc;i tại sự kiện LEEP ASIA 2018.</strong></em></p>

<p>----</p>

<p style="text-align: justify;">► H&atilde;y sẵn s&agrave;ng cho sự trở lại của LEEP ASIA 2018 từ 16/08 đến 19/08/2018.<br />
► Tại Nh&agrave; thi đấu Nguyễn Du số 116 Nguyễn Du, P. Bến Th&agrave;nh, Q.1, Tp.HCM.<br />
► V&eacute; đ&atilde; c&oacute; b&aacute;n tại:&nbsp;<a data-lynx-mode="hover" href="https://l.facebook.com/l.php?u=http%3A%2F%2Fwww.leep.asia%2F&amp;h=AT2OHGIhsXsgZi4yGYUas5sD7aEE0IOOAXpxCiAGLeQrsNEXMQU8GONeac5cx95Jf7DYUKohPy6MtotTClzEGLuLGjgbpG1aI3NlF5Hxvkv0DteLP-CCYj-mXjNihL3sWCk&amp;utm_source=Web&amp;utm_source=seo" rel="nofollow noopener" target="_blank">www.leep.asia</a><br />
Hoặc mua v&eacute; trực tiếp tại trung t&acirc;m California Fitness &amp; Yoga Centers Vietnam, Yoga Plus, UFC Gym Việt Nam v&agrave; California Centuryon gần nhất.</p>

<p style="text-align: center;"><img src="http://images.cfyc.com.vn/Jun%20Bui/loi%20ich%20cua%20yoga%20voi%20benh%20nhan%20ung%20thu/loi-ich-cua-yoga-voi-benh-nhan-ung-thu-8.png" /></p>

<p><br />
<br />
► Đặc biệt, ưu đ&atilde;i 50.000 VND cho mỗi v&eacute; khi mua trực tiếp, d&agrave;nh ri&ecirc;ng cho hội vi&ecirc;n của c&aacute;c thương hiệu n&agrave;y.<br />
► Cập nhật th&ocirc;ng tin sự kiện:&nbsp;<a data-lynx-mode="hover" data-lynx-uri="https://l.facebook.com/l.php?u=https%3A%2F%2Fwww.fb.com%2Fleepasiavn&amp;h=AT2OHGIhsXsgZi4yGYUas5sD7aEE0IOOAXpxCiAGLeQrsNEXMQU8GONeac5cx95Jf7DYUKohPy6MtotTClzEGLuLGjgbpG1aI3NlF5Hxvkv0DteLP-CCYj-mXjNihL3sWCk" href="https://www.fb.com/leepasiavn?utm_source=Web&amp;utm_source=seo" rel="nofollow noopener" target="_blank">https://www.fb.com/leepasiavn</a></p>

<p>#LEEPASIA2018 #CMGAsia #BiggerBetterStronger #XYMLB #MakingLifeBetter #LEEP4LIFE #KickAssCancer #CuringTogether</p>

<p style="text-align: right;"><strong>Ảnh: CFYC</strong></p>

<p style="text-align: right;"><strong>Jun Bui (Calipso)</strong></p>
',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ],
            [
                'id' => 4,
                'thumbnail' => 'http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/trinh%20dien%20ky%20thuat-1.png',
                'category' => 'Blog Kick boxing',
                'title' => 'MUAY THAI FIGHT NIGHT 2018 - CHIẾN ĐẤU ĐỂ CUỘC SỐNG TỐT ĐẸP HƠN',
                'detail' => '
Đêm chung kết Muay Thái Fight Night 2018 đã diễn ra vào ngày 19/08/2018 đã khép lại chuỗi sự kiện LEEP ASIA 2018. Trong bầu không khí náo nhiệt và sôi động từ các cổ động viên và những màn biểu diễn võ thuật đẹp mắt. Ban tổ chức đã tìm ra các võ sĩ xuất sắc chiến thắng tại cuộc thi năm nay. Lắng nghe cảm nghĩ của khách mời về Muay Thái Fight Night 2018 năm nay.',
                'content' => '<p><iframe allow="autoplay; encrypted-media" allowfullscreen="" frameborder="0" height="460" src="https://www.youtube.com/embed/W-hW0HtJxKo" width="666"></iframe></p>

<p>Muay Thai Fight Night l&agrave; một trong những hoạt động nổi bật nằm trong chuỗi sự kiện LEEP ASIA lần n&agrave;y. Đ&acirc;y được xem l&agrave; sự nối tiếp sự th&agrave;nh c&ocirc;ng của Muay Thai Fight Night 2018 diễn ra v&agrave;o th&aacute;ng 7 tại H&agrave; Nội. Những m&agrave;n biểu diễn&nbsp;v&otilde; thuật truyền thống đặc sắc của Th&aacute;i Lan đ&atilde;&nbsp;trở th&agrave;nh một trong những hoạt động&nbsp;s&ocirc;i nổi nhất&nbsp;tại LEEP ASIA 2018.</p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/trinh%20dien%20ky%20thuat-1.png" /></p>

<p style="text-align: center;"><em>Những m&agrave;n biểu diễn&nbsp;v&otilde; thuật truyền thống đặc sắc của Th&aacute;i Lan đ&atilde;&nbsp;trở th&agrave;nh một trong những hoạt động&nbsp;s&ocirc;i nổi nhất&nbsp;tại LEEP ASIA 2018</em></p>

<p>Đ&ecirc;m chung kết&nbsp;Muay Thai Fight Night tối 19/08/2018 tại nh&agrave; thi đấu Nguyễn Du với sự tham dự của nhiều vị kh&aacute;ch qu&yacute; đến từ c&aacute;c cơ quan b&aacute;o đ&agrave;i v&agrave; c&aacute;c quan chức quan trọng của ng&agrave;nh thể thao Việt Nam.&nbsp;Đặc biệt, sự kiện c&ograve;n vinh dự tiếp đ&oacute;n Ng&agrave;i Utalop Bulat &ndash; Đại diện Tổng l&atilde;nh sự Ho&agrave;ng gia Th&aacute;i Lan đến cổ vũ cho c&aacute;c v&otilde; sĩ tham gia thi đấu.</p>

<p data-mce-style="text-align: justify;" style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/marcus.png" /></p>

<p data-mce-style="text-align: justify;" style="text-align: center;"><em>Doanh nh&acirc;n Marcus Guilhem c&ugrave;ng gia đ&igrave;nh đến tham gia cổ vũ cho Muay Thai Fight Night</em></p>

<p>Nhiều cặp trận đấu diễn ra căng thẳng v&agrave; gay cấn đ&atilde; khiến người h&acirc;m mộ cảm thấy rất m&atilde;n nh&atilde;n. C&aacute;c v&otilde; sĩ đ&atilde; thi đấu r&acirc;t nhiệt huyết v&agrave; để lại ấn tượng đẹp trong l&ograve;ng người xem. Trong đ&oacute; cặp trận đấu được mong chờ nhất ch&iacute;nh l&agrave;:&nbsp;<strong>Thani (Th&aacute;i Lan)&nbsp;</strong>thi đấu c&ugrave;ng&nbsp;<strong>Độc c&ocirc; cầu bại &ndash; Nguyễn Trần Duy Nh&acirc;t (Việt Nam).&nbsp;</strong>V&otilde; sĩ Việt Nam được mệnh danh l&agrave; kh&ocirc;ng c&oacute; đối thủ tại đấu trường khu vực v&agrave; l&agrave; nh&agrave; đương kim V&ocirc; địch Muay Thai Thế giới. Đ&acirc;y được xem l&agrave; cặp trận đấu l&agrave;m b&ugrave;ng nổ nh&agrave; thi đấu Nguyễn Du bởi tr&igrave;nh độ ngang t&agrave;i, ngang sức của hai v&otilde; sĩ. Kh&ocirc;ng phụ l&ograve;ng mong mỏi của người h&acirc;m mộ, hai v&otilde; sĩ đ&atilde; cống hiến một lối đ&aacute;nh đầy kĩ thuật v&agrave; l&ocirc;i cuốn. Với kinh nghiệm d&agrave;y dặn tr&ecirc;n c&aacute;c đấu trường quốc tế,&nbsp;<strong>Nguyễn Trần Duy Nhất</strong>&nbsp;đ&atilde; d&agrave;nh chiến thắng chung cuộc với tỉ số 30-27, kh&eacute;p lại một đ&ecirc;m Muay Thai Fight Night m&atilde;n nh&atilde;n v&agrave; quyết liệt.</p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/duc%20le%201.png" /></p>

<p style="text-align: center;"><em>C&aacute;c cuộc chiến c&acirc;n t&agrave;i c&acirc;n sức giữa&nbsp;</em></p>

<p style="text-align: center;"><strong><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/tuan%20nguyen.png" /></strong></p>

<p style="text-align: center;"><em>T&iacute;nh khốc liệt diễn ra trong từng trận đấu</em></p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/quyen-1.png" /></p>

<p style="text-align: center;"><em>Tinh thần chiến đấu thể thao được n&acirc;ng l&ecirc;n tầm cao mới</em></p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/0%20Calipso_Gina/MuayThai%20Fight%20Night/Thani%20vs%20Duy%20Nhat.jpg" /></p>

<p style="text-align: center;"><em><strong>Thani&nbsp;</strong>thi đấu c&ugrave;ng<strong>&nbsp;Nguyễn Trần Duy Nhất&nbsp;</strong>l&agrave; cặp thi đấu được mong chờ nhất</em></p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/duy%20nhat.png" /></p>

<p style="text-align: center;"><em>&quot;Độc c&ocirc; cầu bại&quot; với 7 chiến thắng K.O</em></p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/duy%20nhat-2.png" /></p>

<p style="text-align: center;"><em>Duy Nhất kh&ocirc;ng c&oacute; đối thủ tại đấu trường khu vực</em></p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/duy%20nhat-5.png" /></p>

<p><em>Với kinh nghiệm d&agrave;y dặn tr&ecirc;n c&aacute;c đấu trường quốc tế c&ugrave;ng<strong>&nbsp;Nguyễn Trần Duy Nhất</strong>&nbsp;đ&atilde; d&agrave;nh chiến thắng chung cuộc.&nbsp;Đ&acirc;y l&agrave; trận đấu cuối c&ugrave;ng kh&eacute;p lại sự ki&ecirc;n Muay Thai Fight Night 2018</em></p>

<p><strong>XEM TH&Ecirc;M:&nbsp;<a href="https://lifestyle.cfyc.com.vn/muay-thai-fight-night-khep-lai-leep-asia-2018-voi-nhieu-cam-xuc-nhan-van-p2d2701.html" target="_blank">MUAY THAI FIGHT NIGHT KH&Eacute;P LẠI LEEP ASIA 2018 VỚI NHIỀU CẢM X&Uacute;C NH&Acirc;N VĂN</a></strong></p>

<p>Đặc biệt, trong đ&ecirc;m Muay Thai Fight Night 2018 &ndash; Fight For Life c&ograve;n c&oacute; một trận đấu đặc biệt giữa hai c&ocirc; n&agrave;ng mạnh mẽ trong giới giải tr&iacute; l&agrave; Yaya Trương Nhi v&agrave; Kim Nhung đem lại điểm nhấn th&uacute; vị cho sự kiện. Kết th&uacute;c trận đấu cả hai đều chiến thắng. Được biết, ng&agrave;y mai, 20/08 l&agrave; sinh nhật mẹ Yaya, hiện b&agrave; đang trong bệnh viện điều trị ung thư v&agrave;&nbsp;Yaya Trương Nhi muốn d&agrave;nh trận đấu giao hữu h&ocirc;m nay để tặng mẹ c&ocirc; ấy. Trước khi diễn ra m&agrave;n biểu diễn v&otilde; thuật, Yaya Trương Nhi v&agrave; mọi người đ&atilde; h&aacute;t Happy Birthday&nbsp;để động vi&ecirc;n tinh thần cũng như gửi đến mẹ c&ocirc; lời ch&uacute;c &yacute; nghĩa nhất. Bản th&acirc;n c&ocirc; g&aacute;i nhỏ nhắn nhưng đầy mạnh mẽ n&agrave;y&nbsp;cũng quyết định tặng 20 triệu đồng&nbsp;cho quỹ ung thư của tập đo&agrave;n CMG.Asia, đ&acirc;y l&agrave; sự ủng hộ, đ&oacute;ng g&oacute;p đầy &yacute; nghĩa ph&ugrave; hợp với ti&ecirc;u ch&iacute; cuộc thi cũng như gi&aacute; trị v&agrave; th&ocirc;ng điệp tập đo&agrave;n tr&acirc;n trọng hướng đến.&nbsp;</p>

<p data-mce-style="text-align: justify;" style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/kim%20nhung%20yaya.png" /></p>

<p data-mce-style="text-align: justify;" style="text-align: center;"><em>Trong đ&ecirc;m Muay Thai Fight Night 2018 &ndash; Fight For Life c&ograve;n c&oacute; một trận đấu đặc biệt giữa hai c&ocirc; n&agrave;ng mạnh mẽ trong giới giải tr&iacute; l&agrave; Yaya Trương Nhi v&agrave; Kim Nhung</em></p>

<p data-mce-style="text-align: justify;" style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/kim%20nhung%20yaya-1.png" /></p>

<p data-mce-style="text-align: justify;" style="text-align: center;"><em>Kết th&uacute;c trận đấu cả hai đều chiến thắng</em></p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/kim%20nhung%20yaya-3.png" /></p>

<p style="text-align: center;"><em>Yaya Trương Nhi v&agrave; mọi người đ&atilde; h&aacute;t Happy Birthday&nbsp;để động vi&ecirc;n tinh thần cũng như gửi đến mẹ c&ocirc; đang chống chọi với căn bệnh Ung thư&nbsp;lời ch&uacute;c &yacute; nghĩa nhất</em></p>

<p><strong>XEM TH&Ecirc;M:&nbsp;<a href="https://lifestyle.cfyc.com.vn/yaya-truong-nhi-tran-dau-nay-toi-danh-tang-nguoi-than-dang-phai-chong-choi-voi-can-benh-ung-thu-p2d2702.html" target="_blank">YAYA TRƯƠNG NHI: &ldquo;TRẬN ĐẤU N&Agrave;Y T&Ocirc;I D&Agrave;NH TẶNG NGƯỜI TH&Acirc;N ĐANG PHẢI CHỐNG CHỌI VỚI CĂN BỆNH UNG THƯ&rdquo;</a></strong></p>

<p>Đ&ecirc;m chung kết&nbsp;Muay Thai Fight Night 2018 &ndash; Fight For Life cũng ch&iacute;nh l&agrave; hoạt động cuối c&ugrave;ng kh&eacute;p lại sự kiện&nbsp;LEEP ASIA 2018. Đ&acirc;y l&agrave;&nbsp;chuỗi sự kiện t&iacute;ch cực v&agrave; &yacute; nghĩa, mong rằng sự h&agrave;o hứng v&agrave; phấn khởi khi tham gia của mọi người sẽ khơi gợi ở mỗi người &yacute; thức chăm s&oacute;c sức khỏe, h&igrave;nh thể, sắc đẹp</p>

<p style="text-align: center;"><img alt="" src="http://images.cfyc.com.vn/Jun%20Bui/Recap%20Muay%20Thai%20Fight%20night/san%20khau.png" /></p>

<p style="text-align: center;"><em>Đ&ecirc;m chung kết&nbsp;Muay Thai Fight Night 2018 &ndash; Fight For Life cũng ch&iacute;nh l&agrave; hoạt động cuối c&ugrave;ng kh&eacute;p lại sự kiện&nbsp;LEEP ASIA 2018</em></p>

<p style="text-align: right;"><strong>Jun Bui (Calipso)</strong></p>
',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]
        ]);
    }
}
