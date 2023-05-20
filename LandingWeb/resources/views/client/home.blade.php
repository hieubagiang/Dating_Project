@extends('client.layout.master')
@section('content')
    <header>
        <figure class="intro" id="intro">
            <img src="{{asset('image/1001.png')}}" alt=""/>
            <figcaption>
                hello
            </figcaption>
            <figcaption class=" caption item item--primary"
                        data-aos="fade-left" style="color: #E94057!important">

                <h1>DATING</h1>
                <h2 style="padding-top:60px"> Tìm một người ở đây! </h2>
                {{--                <h4 style="padding-top:60px">Đào tạo cá nhân trực tuyến - cách hiệu quả và tiết kiệm nhất để đạt được mục tiêu tập thể dục của--}}
                {{--                    bạn.--}}
                {{--                    Huấn luyện viên cá nhân của bạn bất cứ nơi nào và bất cứ khi nào bạn muốn!</h4>--}}
            </figcaption>
            <span class="overlay">
<svg version="1.1" id="circle" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"
     y="0px"
     viewBox="0 0 500 250" enable-background="new 0 0 500 250" xml:space="preserve" PreserveAspectRatio="none">
<path fill="#FFFFFF"
      d="M250,246.5c-97.85,0-186.344-40.044-250-104.633V250h500V141.867C436.344,206.456,347.85,246.5,250,246.5z"
/>
</svg>
  </span>
        </figure>

    </header>
    <div class="home-gt">
        <div class=" home-title">Tại sao bạn nên chọn Dating?</div>
        <div class="container">
            {{--        demo1--}}
            <div class="row gt-pt">
                <div class="col-sm-6" data-aos="fade-in"><img class="img-gt" width="100%" height="auto"
                                                              src="{{asset('image/1004.jpg')}}"
                                                              alt=""></div>
                <div class="col-sm-6 pl-5" data-aos="fade-up">
                    <div class="row text-gt" style="color: #E94057"> Cùng chúng tôi chu du khắp thiên hạ</div>
                    {{--                            <div class="row text-title-pt">Kết bạn mọi nơi</div>--}}
                    Khi bạn muốn gặp gỡ người bản địa thì dù bạn đang ở bất kỳ thành phố nào trên thế giới, sẽ luôn
                    có một ứng dụng giúp bạn thỏa lòng thỏa chí — đó chính là Dating. Chat với mọi người "dù gần nhà hay xa ngõ"
                    qua các tính năng cho phép bạn nối dây "tơ hồng" với bất kỳ ai ở bất kỳ đâu trên thế giới này.
                    Dating chính là người bạn đồng hành trong chuyến chu du thỏa chí tang bồng của bạn.
                    Chúng tôi có khả năng đưa bạn tới gần hơn với 190 quốc gia, điều mà ngay cả mấy huynh đệ bên OKCupid và Plenty of Fish cũng khó nói mạnh được.
                </div>
            </div>
            {{--demo2--}}
            <div class="row gt-pt">
                <div class="col-sm-6" data-aos="zoom-in">
                    <div class="row text-gt" style="color: #E94057">Khám phá các sở thích của bạn</div>
                    {{--                    <div class="row text-title-pt">Đáp ứng mọi nhu cầu</div>--}}
                    Thật dễ dàng trò chuyện với bạn tương hợp khi biết rằng hai bên có chung một vài sở thích.
                    Ứng dụng Dating cho phép bạn thêm Sở thích vào hồ sơ của mình và kết nối với những người cùng chung "chí hướng".
                </div>
                <div class="col-sm-6 " data-aos="zoom-in"><img class="img-gt" width="100%" height="auto"
                                                               src="{{asset('image/1005.jpg')}}"
                                                               alt=""></div>
            </div>
            {{--demo3            --}}
            <div class="row gt-pt">
                <div class="col-sm-6" data-aos="fade-in"><img class="img-gt" width="100%" height="auto"
                                                              src="{{asset('image/1003.jpg')}}"
                                                              alt=""></div>
                <div class="col-sm-6 pl-5" data-aos="fade-up">
                    <div class="row text-gt" style="color: #E94057"> Hẹn hò an toàn hơn</div>
                    {{--                    <div class="row text-title-pt">Kết bạn mọi nơi</div>--}}
                    Ai mà chẳng có chút háo hức khi gặp gỡ người mới ngoài đời,
                    nhưng hẹn hò trong thời COVID-19 đâu phải chuyện dễ dàng vì
                    chúng ta đều phải đặt an toàn lên hàng đầu. Khi mà khoảng cách giữa
                    hai người 2 mét vẫn là chưa đủ để đảm bảo an toàn thì Dating
                    chính là cứu cánh giúp chúng ta thỏa ước trò chuyện với bạn tương hợp,
                    để các bạn có thể giữ kết nối qua mạng.
                </div>
            </div>


            {{--demo4--}}
            <div class="row gt-pt">
                <div class="col-sm-6" data-aos="zoom-in">
                    <div class="row text-gt" style="color: #E94057">Kết nối tương hợp ngay trong tầm tay</div>
                    {{--                    <div class="row text-title-pt">Đáp ứng mọi nhu cầu</div>--}}
                    Một trong những quyết định chín chắn nhất mà bạn đưa ra chính là
                    lựa chọn một ứng dụng hẹn hò có khả năng mang đến mọi thứ mà ứng
                    dụng cũ của bạn đã không thể thực hiện được. Và đó không chỉ đơn giản
                    là chuyện chọn lựa giữ Badoo hay Zoosk. Gặp gỡ mọi người trên mạng là
                    cả một hành trình, thứ bạn muốn chính là "ai đó" đáng tin cậy cùng bạn
                    đồng hành trong suốt hành trình ấy. Nói đến chuyện tìm bạn tương hợp,
                    Dating có thể đảm đương vị trí hoa tiêu đồng hành cùng bạn.
                </div>
                <div class="col-sm-6 " data-aos="zoom-in"><img class="img-gt" width="100%" height="auto"
                                                               src="{{asset('image/1007.png')}}"
                                                               alt=""></div>
            </div>
            {{--        demo5--}}
            <div class="row gt-pt">
                <div class="col-sm-6" data-aos="fade-in"><img class="img-gt" width="100%" height="auto"
                                                              src="{{asset('image/1006.jpg')}}"
                                                              alt=""></div>
                <div class="col-sm-6 pl-5" data-aos="fade-up">
                    <div class="row text-gt" style="color: #E94057">Trọn gói, mọi lúc mọi nơi</div>
                    {{--                    <div class="row text-title-pt">Kết bạn mọi nơi</div>--}}
                    Chúng tôi không phải là fan hâm mộ mấy thứ nhãn mác bên ngoài, vậy nên chúng tôi
                    mang đến trải nghiệm hẹn hò được thiết kế nhằm kết nối bạn với người mới ngoài
                    nhóm bạn bè thường ngày của bạn. Không giống như các trang như Bumble, Dating không
                    lọc đối tượng theo chiều cao, học vấn, chủng tộc hay tín ngưỡng vì nhân khẩu học đâu
                    có thể nói lên gì nhiều về một con người. Chúng tôi tin mỗi người đều có quyền được
                    nhìn nhận và tự mình quyết định bước tiến đầu tiên bất kể nhân dạng của họ ra sao.
                    Trên ứng dụng của mình, chúng tôi luôn ưu tiên giới thiệu mọi người với bạn và để
                    bạn có toàn quyền lựa chọn đối tượng mình muốn cùng trò chuyện.
                </div>
            </div>

        </div>
    </div>


    <div style="background:linear-gradient(180deg,#E94057 0%,#E94057 50%) !important;position: relative;background-position: center;">
        <div class=" curved"></div>
        {{--        <div class="home-title mb-2" style="color: white" data-aos="zoom-in"> Huấn luyện viên</div>--}}
        <div class="home-hovereffect">
            <img class="img-responsive" width="100%" height="auto"
                 src="{{asset('image/1010.jpg')}}" alt="">
            <div class="home-overlay">
                <h1 style="color: white">Tuấn Anh Vũ</h1>
                <h2>FA lâu năm chính hiệu</h2>
            </div>
        </div>
        <div class="container">
            <div class="row mt-5">
                <div class="col-sm-8 text-gt-pt" data-aos="fade-right">
                    <h4> Tôi là Tuấn Anh Vũ.
                    </h4>
                    <h4>Nhờ có Dating, tôi đã tìm thấy người yêu của đời mình và chúng tôi sắp kết hôn.

                        Sau khi trải qua vài buổi hẹn hò và mấy buối tối vui vẻ, tôi tình cờ gặp được
                        Miranda. Sau khi đọc hồ sơ của cô ấy, tôi đã không thể không vuốt phải chọn
                        cô ấy sau khi đọc câu kết trong đó… 'Đang tìm kiếm nửa còn lại của đời tôi.'
                        Sau khi trò chuyện khoảng một tuần, chúng tôi tiến tới cuộc hẹn gặp đầu tiên
                        và tôi biết ở cô ấy có điều gì đó rất đặc biệt!</h4>
                </div>
                <div class="col-sm-4 pl-5" data-aos="fade-left">
                    <div class=" col-sm-10 img-chungchi">
                        <img width="100%" height="auto"
                             src="{{asset('image/1009.jpg')}}"
                             alt="">
                    </div>
                </div>
            </div>
        </div>
        <div class=" curved-end"></div>
    </div>
    <div class="container">
        <div class="home-title mb-2"> Tương hợp. Trò chuyện. Gặp gỡ</div>
        <div class="row">
            <div class="col-sm-5" style="padding-top: 10%;padding-right: 5%" data-aos="zoom-in">
                <div data-aos="zoom-in">
                    <h4 class="mb-3" style="line-height: 2.5rem">
                        Vượt ra khỏi những quen biết thường ngày và kết nối với mọi người xa
                        gần khắp nơi. Bạn chuẩn bị có trải nghiệm hẹn hò trực tuyến hấp dẫn nhất
                        — tất cả những gì bạn cần là một vài tấm hình đẹp và một tiểu sử rõ
                        ràng để nổi bật.</h4>
                </div>
                <div data-aos="zoom-in" class="container-gt-pt">
                    <a href="/download" style="text-decoration: none" class="btn-gt-pt">
                        <svg width="277" height="62">
                            <a href="/download"><span class="text-uppercase font-weight-bold">Tải về ngay</span></a>
                            <defs>
                                <linearGradient id="grad1">
                                    <stop offset="0%" stop-color="rgb(46, 220, 255)"/>
                                    <stop offset="100%" stop-color="#E178ED"/>
                                </linearGradient>
                            </defs>
                            <rect x="5" y="5" rx="25" fill="none" stroke="url(#grad1)" width="266"
                                  height="50"></rect>
                        </svg>
                        <!--<span>Voir mes réalisations</span>-->

                    </a>
                </div>
            </div>
            <div class="col-sm-7 col-gtdingduong" data-aos="zoom-in">
                <img loading="lazy" alt="Đối tượng Tương hợp!" class=""
                     draggable="true"
                     src="{{asset('image/00.webp')}}">
            </div>
        </div>
@endsection
