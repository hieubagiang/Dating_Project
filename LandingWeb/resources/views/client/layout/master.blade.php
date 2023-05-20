<?php
$urlName = Request::url();
$check = preg_match('/blog/', $urlName);
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="{{asset('css/app.css')}}">
    <link rel="stylesheet" href="{{asset('css/style.css')}}">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.1/css/all.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Livvic&display=swap" rel="stylesheet">
    <script src="{{asset('js/app.js')}}"></script>
    <link rel="icon" href="{{asset('image/home.png')}}" sizes="16x16 32x32">
    <title>Dating</title>

</head>
<body>
<div class="hh">
    <div class="row header-style floatingNav" id="navbar" style="width: 100%">
        <div class="col-2 logo-header mt-2 mb-2 " style="padding-left: 0px">
            <a href="{{route('home')}}"><img src="{{asset('image/home.png')}}" style="width: 70px"  alt="..."
                             class=" logo-image"></a>
        </div>
        <div class="col-8 navbar-header" >
            <nav class="navbar navbar-expand-lg navbar-light bg-light layout-nav-bar navbar-header-control " style="width: 1000px !important;">
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav dropdown link-header  text-title-header " style="padding-left: 0px">
                       <a class="navbar-brand nav-link " href="/"
                          style=" {{ $urlName == 'http://127.0.0.1:8000' ? 'color: #E94057!important;' : ''}}" >
                           Sản phẩm
                       </a>

                            <a class="navbar-brand nav-link " href="/policy"
                               style=" {{ preg_match('/policy/', $urlName) ? 'color: #E94057!important;' : ''}}">
                                Điều khoản</a>
                        <a class="navbar-brand nav-link " href="/download"
                           style=" {{ preg_match('/download/', $urlName) || preg_match('/download/', $urlName) ? 'color: #E94057!important;' : ''}}">
                            Tải về</a>

                    </div>
                </div>
            </nav>
        </div>
        {{--    <div class="col-1 ml-5 d-flex justify-content-end icon-user-header">--}}
        {{--        <a href="#"></a>--}}
        {{--    </div>--}}

{{--        --}}
    </div>
    <i class="fas fa-chevron-up" onclick="topFunction()" id="myBtn" title="Lên đầu trang"></i>
    <div>
        @section('content')
        @show()
    </div>
</div>
<footer class="page-footer font-small unique-color-dark footer-layout" style="margin-top: 30px;background-color: #E94057!important;">
    <div class="container text-center text-md-left ">

        <!-- Grid row -->
        <div class="row mt-1 text-footer-detail">

            <!-- Grid column -->
            <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4 text-footer-control">

                <!-- Content -->
                <h6 class="text-uppercase font-weight-bold">Dating</h6>
                <hr class="deep-purple accent-2 mb-2 mt-0 d-inline-block mx-auto" style="width: 60px;">
                <p>Chúng tôi không hề nói quá về chuyện Dating là một trang app
                    miễn phí cool nhất — hãy thử tìm hiểu nhanh về Dating và
                    bạn có toàn quyền quyết định xem liệu chuyện này có thật như những gì mọi người vẫn nói.</p>

            </div>
            <!-- Grid column -->

            <!-- Grid column -->
            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4 text-footer-control">

                <!-- Links -->
                <h6 class="text-uppercase font-weight-bold">liên kết</h6>
                <hr class="deep-purple accent-2 mb-2 mt-0 d-inline-block mx-auto" style="width: 60px;">
                <p>
                    <a href="/">Sản phẩm</a>
                </p>
                <p>
                    <a href="/policy">Điều khoản</a>
                </p>
                <p>
                    <a href="/download">Tải về</a>
                </p>

            </div>
            <!-- Grid column -->



            <!-- Grid column -->
            <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4 text-footer-control ">

                <!-- Links -->
                <h6 class="text-uppercase font-weight-bold">Liên hệ</h6>
                <hr class="deep-purple accent-2 mb-2 mt-0 d-inline-block mx-auto" style="width: 60px;">
                <p>
                    <i class="fas fa-home mr-3"></i>Số 141 Chiến Thắng</p>
                <p>
                    <i class="fas fa-envelope mr-3 mt-3"></i> Dating@gmail.com</p>
                <p>
                    <i class="fas fa-phone mr-3 mt-3"></i> 0869343091</p>

            </div>
        </div>

    </div>
    <div class="social-icon d-flex justify-content-center">
        <div class="row ">
            <div class="col-md-12  py-5 social-icon-layout">
                <div class=" flex-center">
                    <!-- Facebook -->
                    <a class="fb-ic" href="https://www.facebook.com/">
                        <i class="fab fa-facebook-f fa-lg white-text mr-md-5 mr-3 "> </i>
                    </a>
                    <!-- Twitter -->
                    <a class="tw-ic" href="https://twitter.com/">
                        <i class="fab fa-twitter fa-lg white-text mr-md-5 mr-3 "> </i>
                    </a>
                    <!-- Google +-->
                    <a class="gplus-ic" href="https://mail.google.com/">
                        <i class="fab fa-google-plus-g fa-lg white-text mr-md-5 mr-3 "> </i>
                    </a>
                    <!--Instagram-->
                    <a class="ins-ic" href="https://www.instagram.com/">
                        <i class="fab fa-instagram fa-lg white-text mr-md-5 mr-3 "> </i>
                    </a>
                    <!--Pinterest-->
                    <a class="pin-ic" href="https://www.pinterest.com/">
                        <i class="fab fa-pinterest fa-lg white-text "> </i>
                    </a>
                </div>
            </div>
            <!-- Grid column -->
        </div>
        <!-- Grid row-->
    </div>
    <div class="footer-copyright text-center py-3 ">Copyright Group_6 2022 <br>
    </div>
</footer>
<script src="{{asset('js/app.js')}}"></script>
<script src="{{asset('js/client/layout.js')}}"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    window.onscroll = function () {
        scrollFunction()
    };

    function scrollFunction() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            document.getElementById("myBtn").style.display = "block";
        } else {
            document.getElementById("myBtn").style.display = "none";
        }
    }

    // When the user clicks on the button, scroll to the top of the document
    function topFunction() {
        document.body.scrollTop = 0;
        document.documentElement.scrollTop = 0;
    }
</script>
<script>
    AOS.init({
        offset: 120,
        delay: 1,

        easing: 'ease',

        duration: 1000,

        disable: false,

        once: true,

        mirror: true, // whether elements should animate out while scrolling past them

        startEvent: 'DOMContentLoaded'
    });
</script>
<script>
    function inViewport($el) {
        var H = $(window).height(),
            r = $el[0].getBoundingClientRect(), t = r.top, b = r.bottom;
        return Math.max(0, t > 0 ? H - t : (b < H ? b : H));
    }

    $(window).on("scroll resize", function () {
        var window_offset = inViewport($('.intro'));
        $(".overlay").height(window_offset);
        $(".caption").css("bottom", (window_offset / 4));
    });

    class ShapeOverlays {
        constructor(elm) {
            this.elm = elm; // Parent SVG element.
            this.path = elm.querySelectorAll('path'); // Path elements in parent SVG. These are the layers of the overlay.
            this.numPoints = 18; // Number of control points for Bezier Curve.
            this.duration = 600; // Animation duration of one path element.
            this.delayPointsArray = []; // Array of control points for Bezier Curve.
            this.delayPointsMax = 300; // Max of delay value in all control points.
            this.delayPerPath = 60; // Delay value per path.
            this.timeStart = Date.now();
            this.isOpened = false;

        }
    }

    $(window).scroll(function () {
        if ($(window).scrollTop() > 15) {
            $('#navbar').addClass('floatingNav');
        } else {
            $('#navbar').removeClass('floatingNav');

        }
    });
    $('#myCarousel').carousel({
        interval: 5000
    });

    //Handles the carousel thumbnails
    $('[id^=carousel-selector-]').click(function () {
        var id_selector = $(this).attr("id");
        try {
            var id = /-(\d+)$/.exec(id_selector)[1];
            console.log(id_selector, id);
            jQuery('#myCarousel').carousel(parseInt(id));
        } catch (e) {
            console.log('Regex failed!', e);
        }
    });
    // When the carousel slides, auto update the text
    $('#myCarousel').on('slid.bs.carousel', function (e) {
        var id = $('.item.active').data('slide-number');
        $('#carousel-text').html($('#slide-content-' + id).html());
    });
    $(document).ready(function () {
        var itemsMainDiv = ('.MultiCarousel');
        var itemsDiv = ('.MultiCarousel-inner');
        var itemWidth = "";

        $('.leftLst, .rightLst').click(function () {
            var condition = $(this).hasClass("leftLst");
            if (condition)
                click(0, this);
            else
                click(1, this)
        });

        ResCarouselSize();


        $(window).resize(function () {
            ResCarouselSize();
        });

        //this function define the size of the items
        function ResCarouselSize() {
            var incno = 0;
            var dataItems = ("data-items");
            var itemClass = ('.item');
            var id = 0;
            var btnParentSb = '';
            var itemsSplit = '';
            var sampwidth = $(itemsMainDiv).width();
            var bodyWidth = $('body').width();
            $(itemsDiv).each(function () {
                id = id + 1;
                var itemNumbers = $(this).find(itemClass).length;
                btnParentSb = $(this).parent().attr(dataItems);
                itemsSplit = btnParentSb.split(',');
                $(this).parent().attr("id", "MultiCarousel" + id);


                if (bodyWidth >= 1200) {
                    incno = itemsSplit[3];
                    itemWidth = sampwidth / incno;
                } else if (bodyWidth >= 992) {
                    incno = itemsSplit[2];
                    itemWidth = sampwidth / incno;
                } else if (bodyWidth >= 768) {
                    incno = itemsSplit[1];
                    itemWidth = sampwidth / incno;
                } else {
                    incno = itemsSplit[0];
                    itemWidth = sampwidth / incno;
                }
                $(this).css({'transform': 'translateX(0px)', 'width': itemWidth * itemNumbers});
                $(this).find(itemClass).each(function () {
                    $(this).outerWidth(itemWidth);
                });

                $(".leftLst").addClass("over");
                $(".rightLst").removeClass("over");

            });
        }


        //this function used to move the items
        function ResCarousel(e, el, s) {
            var leftBtn = ('.leftLst');
            var rightBtn = ('.rightLst');
            var translateXval = '';
            var divStyle = $(el + ' ' + itemsDiv).css('transform');
            var values = divStyle.match(/-?[\d\.]+/g);
            var xds = Math.abs(values[4]);
            if (e == 0) {
                translateXval = parseInt(xds) - parseInt(itemWidth * s);
                $(el + ' ' + rightBtn).removeClass("over");

                if (translateXval <= itemWidth / 2) {
                    translateXval = 0;
                    $(el + ' ' + leftBtn).addClass("over");
                }
            } else if (e == 1) {
                var itemsCondition = $(el).find(itemsDiv).width() - $(el).width();
                translateXval = parseInt(xds) + parseInt(itemWidth * s);
                $(el + ' ' + leftBtn).removeClass("over");

                if (translateXval >= itemsCondition - itemWidth / 2) {
                    translateXval = itemsCondition;
                    $(el + ' ' + rightBtn).addClass("over");
                }
            }
            $(el + ' ' + itemsDiv).css('transform', 'translateX(' + -translateXval + 'px)');
        }

        //It is used to get some elements from btn
        function click(ell, ee) {
            var Parent = "#" + $(ee).parent().attr("id");
            var slide = $(Parent).attr("data-slide");
            ResCarousel(ell, Parent, slide);
        }

    });
    var nextButton = $("#right-btn");
    var backButton = $("#left-btn");
    var con = $("#cont");
    var sliderCont = $("#slider-container");

    var sldElm = $(".item-image-wrapper img");
    var i = 0;
    while (i < sldElm.length) {
        sldElm[i].setAttribute("draggable", false);
        i++
    }

    var mL = 0, maxX = 200, diff = 0;

    function slide() {
        mL -= 100;
        if (mL < -maxX) {
            mL = 0;
        }
        sliderCont.animate({"margin-left": mL + "%"}, 800);
    }

    function slideBack() {
        mL += 100;
        if (mL > 0) {
            mL = -200;
        }
        sliderCont.animate({"margin-left": mL + "%"}, 800);
    }

    nextButton.click(slide);
    backButton.click(slideBack);

    $(document).on("mousedown touchstart", con, function (e) {

        var startX = e.pageX || e.originalEvent.touches[0].pageX;
        diff = 0;

        $(document).on("mousemove touchmove", function (e) {

            var xt = e.pageX || e.originalEvent.touches[0].pageX;
            diff = (xt - startX) * 100 / window.innerWidth;
            if (mL == 0 && diff > 10) {
                event.preventDefault();
            } else if (mL == -maxX && diff < -10) {
                event.preventDefault();
            } else {
                sliderCont.css("margin-left", mL + diff + "%");
            }
        });
    });
    $(".alert").delay(4000).slideUp(200, function() {
        $(this).alert('close');
    });
    $(document).on("mouseup touchend", function (e) {
        $(document).off("mousemove touchmove");
        if (mL == 0 && diff > 4) {
            sliderCont.animate({"margin-left": 0 + "%"}, 100);
        } else if (mL == -maxX && diff < 4) {
            sliderCont.animate({"margin-left": -maxX + "%"}, 100);
        } else {
            if (diff < -10) {
                slide();
            } else if (diff > 10) {
                slideBack();
            } else {
                sliderCont.animate({"margin-left": mL + "%"}, 300);
            }
        }
    });
    $('.dropdown-menu li').on('click', function () {
        var getValue = $(this).text();
        $('.dropdown-select').text(getValue)
    });

</script>
<link href="https://sandbox.vnpayment.vn/paymentv2/lib/vnpay/vnpay.css" rel="stylesheet"/>
<script src="https://sandbox.vnpayment.vn/paymentv2/lib/vnpay/vnpay.js"></script>
<script src="{{asset('js/checkout.js')}}"></script>

</body>
</html>
