@extends('client.layout.master')
@section('content')
<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header"><h2>Đăng nhập thành công!</h2></div>

                <div class="card-body">
                    @if (session('status'))
                        <div class="alert alert-success" role="alert">
                            {{ session('status') }}
                        </div>
                    @endif
                    Chúc mừng bạn đã đăng nhập thành công.

                </div>
            </div>
        </div>
    </div>
</div>
@endsection
