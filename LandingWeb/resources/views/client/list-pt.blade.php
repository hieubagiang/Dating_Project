@extends('client.layout.master')
@section('content')
    @php
        $urlName = Request::fullUrl();
    @endphp
    <div class="list-pt pt-content"
         style="background:linear-gradient(180deg,#0072ff 0%,#00c6ff 100%) !important; padding-top: 80px">
        <h1 class="list-pt-title font-weight-bold text-center " style="line-height: 140px;font-size: 50px">Danh sách
            huấn luyện
            viên</h1>
        <div class="curved-end"></div>
    </div>
    <div class="container mt-5">
        <div class="row">
            <div class="col-3">
                <div class="list-cate">
                    <div><a href="/personal-training" class="pt-cate">Tất cả</a></div>
                    <div><img class="mr-3" width="40px"
                              src="https://img.icons8.com/ios-filled/50/000000/personal-trainer.png"><a href="/category/1" class="pt-cate"
                                                                                                        style=" {{ $urlName == 'http://127.0.0.1:8000/category/1' ? 'color: dodgerblue!important;' : ''}}">
                            HLV Cá Nhân</a></div>
                    <div><img class="mr-3" width="40px" src="https://img.icons8.com/ios-filled/50/000000/yoga.png"> <a
                            href="/category/2" class="pt-cate"
                            style=" {{  $urlName == 'http://127.0.0.1:8000/category/2' ? 'color: dodgerblue!important;' : ''}}">Yoga</a></div>
                    <div><img class="mr-3" width="40px"
                              src="https://img.icons8.com/ios-filled/50/000000/swimming.png"><a href="/category/3" class="pt-cate"
                                                                                                style=" {{ preg_match('/3/', $urlName) ? 'color: dodgerblue!important;' : ''}}">Bơi Lội</a>
                    </div>
                    <div><img class="mr-3" width="40px"
                              src="https://img.icons8.com/ios-glyphs/60/000000/boxing-2.png"><a href="/category/4"
                                                                                                class="pt-cate" style=" {{ preg_match('/4/', $urlName) ? 'color: dodgerblue!important;' : ''}}">Kick
                            Boxing</a></div>
                    <div><img class="mr-3" width="40px" src="https://img.icons8.com/ios-filled/50/000000/dancing.png"><a
                            href="/category/5" class="pt-cate"
                            style=" {{ preg_match('/5/', $urlName) ? 'color: dodgerblue!important;' : ''}}">Khiêu Vũ</a></div>
                </div>
            </div>
            <div class="col-9">
                <div class="row">
                    <div class="col-8"></div>
                    <div class="col-4 d-flex justify-content-center" style="">
                        <div class="dropdown show">
                            <a class="btn btn-default dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #6c757d;border:2px solid ;width: 233px">
                                @if (request('orderBy') === 'rate')
                                    Rating
                                @elseif (request('orderBy') === 'created_at')
                                    New
                                @else
                                    Tất cả
                                @endif
                            </a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                <a class="dropdown-item" href="/personal-training/?orderBy=rate">Rating</a>
                                <a class="dropdown-item" href="/personal-training/?orderBy=created_at">New</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-4">
                    @foreach($list as $item)
                        <div class="grid col-sm-4">
                            <figure class="effect-goliath" data-aos="zoom-in">

                                <img width="100%" height="auto"
                                     src="{{$item->image}}"
                                     alt="img23"/>

                                <figcaption>
                                    <h2 class="text-center">{{$item->name}}<br>
                                        <div class="star-ratings-sprite"><span style="width:{{$item->rating}}%"
                                                                               class="star-ratings-sprite-rating"></span>
                                        </div>
                                    </h2>
                                    <p class="pb-3 bg-dark" style="width: 100%">
                                        {{$item->description}}</p>
                                    <a href="/personal-training/{{$item->id}}">View more</a>
                                </figcaption>
                            </figure>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>
    </div>
@endsection
