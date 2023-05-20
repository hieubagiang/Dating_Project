<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RoleController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }
    public function roleAdmin(){
        $user =Auth::user();
        if ($user->hasRole('admin')) {
            return  view('admin/home');
        }else{
            return "ban khong phai la admin";
        }
    }

    public function roleUser(){
        $user =Auth::user();
        if ($user->hasRole(['user', 'admin'])) {
            return view('client/home');
        }else{
            return redirect('/login');
        }
    }

    public  function roleGuest(){
        return redirect('/');
    }
}
