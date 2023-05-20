<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::get('/policy', function () {
    return view('client/policy');
}) -> name('policy');
Route::get('/', function () {
    return view('client.home');
})->name('home');
Route::get('/download', function () {
    return view('client/index-body/do-chi-so-co-the');
});
Route::get('/file', function() {
    return true;
});

