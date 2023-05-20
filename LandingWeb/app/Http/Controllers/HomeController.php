<?php

namespace App\Http\Controllers;

use App\Home;
use App\Blog;
use Illuminate\Http\Request;
use JD\Cloudder\Facades\Cloudder;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        $list = Home::whereNotIn('status', [-1])->paginate(10);
        $data = ['list' => $list];
        return view('admin.home.list',$data);
    }
    public function index2()
    {
        $list = Home::whereNotIn('status', [1]) ->paginate(10);
        $data = ['list' => $list];
        return view('admin.home.deleted-home', $data);
    }
    public function create()
    {
        return view('admin.home.form');
    }
    public function store(Request $request)
    {
        $home = new Home();
        $home->title = $request->title;
        $home->description = $request->description;
        $home->content = $request->contentcheck;
        $files = $request->file('image');
        $image_url = '';
        foreach ($files as $file) {
            $img = $file->getRealPath();
            Cloudder::upload($img, null);
            $image_url .= Cloudder::show(Cloudder::getPublicId());
        }
        $home->image = $image_url;
        $home->save();
        return redirect('admin/home');
    }
    public function show($id)
    {
        $home = Home::find($id);
        $data = ['home' => $home];
        return view('admin.home.detail', $data);
    }
    public function edit($id)
    {
        $home = Home::find($id);
        $data = ['home' => $home];
        return view('admin.home.edit', $data);
    }
    public function update(Request $request, $id)
    {
        $home = Home::findOrFail($id);
        $home->title = $request->input('title');
        $home->detail = $request->input('description');
        $home->content = $request->input('contentcheck');
        $files = $request->file('image');
        $image_url = '';
        foreach ($files as $file) {
            $img = $file->getRealPath();
            Cloudder::upload($img, null);
            $image_url .= Cloudder::show(Cloudder::getPublicId());
        }
        $home->image = $image_url;
        $home->save();
        return redirect('admin/home');
    }
    public function destroy($id)
    {
        error_log('Some message here.');
        $home = Home::find($id);
        $home->status = -1;
        $home->save();
        return response()->json(['status' => '200', 'message' => 'Okie']);
    }
    public function changeStatus(Request $request)
    {
        $listItem = Home::whereIn('id', $request->input('ids'));
        $listItem->update(array(
            'status' => (int)$request->input('status'),
            'updated_at' => date('Y-m-d H:i:s')));
        return response()->json(['status' => '200', 'message' => 'Good']);
    }
    public function index3()
    {
        $list = Home::all();
        $blogs = Blog::latest()->get();
        return view('client.home',compact('list','blogs'));
    }
}
