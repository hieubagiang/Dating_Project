@extends('client.layout.master')
@section('content')
    <div class="main-body-index" style="background-color: #fefefe">
        <div class="row">
            <div class="col-7 text-center" style="padding-top: 170px">
                <h2 style="color: blue">Trước Tiên</h2>
                <h4>Hãy cung cấp một số thông tin</h4>
                <form action="/index-body-3" method="post">
                    @csrf
                    <div class="row">
                        <div class="form-text col-6" style="padding-left: 200px">
                            Giới tính
                        </div>
                        <div class="col-6" style="padding-right: 200px">
                            <input type="radio" name="sex_section" value="1" class="sex_section" required>
                            <i class="fas fa-male fa-3x" style="padding-right: 40px"></i>
                            <input type="radio" name="sex_section" value="0" class="sex_section" required>
                            <i class="fas fa-female fa-3x"></i>
                        </div>
                        <div class="form-text col-6" style="padding-left: 200px">
                            Cân Nặng
                        </div>
                        <div class="col-6" style="padding-right: 200px">
                            <input type="text" name="weight" class="input-mini-all" required>
                            <span class="span">kg</span>
                        </div>
                        <div class="form-text col-6" style="padding-left: 200px">
                            Chiều Cao
                        </div>
                        <div class="col-6" style="padding-right: 200px">
                            <input type="text" name="height" class="input-mini-all" required>
                            <span class="span">cm</span>
                        </div>
                        <div class="form-text col-6" style="padding-left: 200px">
                            Tuổi
                        </div>
                        <div class="col-6" style="padding-right: 250px">
                            <input type="text" name="age" class="input-mini-all" required>
                        </div>
                        <div class="form-text col-6" style="padding-left: 200px">
                            Mức Độ Luyện Tập
                        </div>
                        <div class="col-6" style="padding-right: 140px">
                            <select name="training" style="height: 50px; font-size: 15px;border-radius: 5px" >
                                <option value="0">Không Luyện Tập</option>
                                <option value="1">Ít Luyện Tập</option>
                                <option value="2">Tập Luyện Vừa Phải</option>
                                <option value="3">Thường Xuyên Tập Luyện</option>
                            </select>
                        </div>
                    </div>
                    <div class="btn-index-body">
                        <button type="submit" class="btn btn-primary">TIẾP TỤC</button>
                        <a href="index-body"><button type="button" class="btn btn-light">TRỞ lẠI</button></a>
                    </div>
                </form>
            </div>
            <div class="col-5">
                <img src="{{asset('image/index-body.png')}}" class="img-body-index" alt="...">
            </div>
        </div>
    </div>
@endsection

