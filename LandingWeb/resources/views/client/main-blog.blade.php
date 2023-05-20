@extends('client.layout.master')
@section('content')
    <div class="banner-header">
        <img src="https://www.fusionfitnessacademy.org/wp-content/uploads/2018/05/slider2.jpg" class="rounded img-fluid"
             alt="Responsive image">
    </div>
    <div class="detail" style="padding-top: 120px">
        <h1 class="text-center">Dịch vụ luyện tập thể dục</h1>
        <h1 class="text-center">Và các lưu ý giảm cân hiệu quả</h1>
        <hr class="coll-divider short-red-line center">
    </div>
    <div class="container">
        <section class="introduce-1">
            <div class="row">
                @foreach($blog as $blogs)
                    <div class="col-lg-6 col-sm-12 introduce-1-img" data-aos="fade-left">

                            <img class="img-responsive"
                                 src="{{$blogs->thumbnail}}"
                                 alt="">

                        <div class="text-img">
                            <a href="{{route('client.blog.show',$blogs->id)}}" style="color: black"><h4>{{$blogs->title}}</h4></a>
                        </div>
                        <div class="text2-img">
                            <a style="text-decoration: none" href="{{route('client.blog.show',$blogs->id)}}"><h4 href="#">Chi tiết</h4></a></div>
                        <p>
                            {{$blogs->detail}}
                        </p>
                        <hr class="coll-divider short-bg-line center">
                        <a>
                            <hr class="coll-divider short-bg-line center">
                            <i class="fas fa-pen-square"> {{$blogs->category}} </i>
                            <i class="far fa-calendar-alt" style="float: right"> {{$blogs->created_at}} </i>
                            <hr class="coll-divider short-bg-line center">
                        </a>
                    </div>
                @endforeach
            </div>
        </section>

    </div>
@endsection
