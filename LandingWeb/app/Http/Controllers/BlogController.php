<?php

namespace App\Http\Controllers;

use App\Blog;
use App\Http\Requests\AddBlogValidate;
use Faker\Provider\Image;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Input;
use JD\Cloudder\Facades\Cloudder;

class BlogController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $blog = Blog::whereNotIn('status', [-1])->latest()->paginate(6);
        return view('admin/blog/list-blog')->with(['blog' => $blog]);
    }

    public function index2()
    {
        $blog = Blog::whereNotIn('status', [1]) ->paginate(6);
        $data = ['blog' => $blog];
        return view('admin/blog/deleted-blog', $data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin/blog/create-blog');

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return string
     */
    public function store(AddBlogValidate $request)
    {
        $request ->validated();
        $blog = new Blog();
        $blog->category = $request->category;
        $blog->title = $request->title;
        $blog->detail = $request->detail;
        $blog->content = $request->contentcheck;
        $files = $request->file('thumbnail');
        $image_url = '';
        foreach ($files as $file) {
            $img = $file->getRealPath();
            Cloudder::upload($img, null);
            $image_url .= Cloudder::show(Cloudder::getPublicId());
        }
        $blog->thumbnail = $image_url;

        $blog->save();


        //dd($userImage);


        return redirect('admin/blog')->withSuccess('thêm thành công');
    }


    /**
     * Display the specified resource.
     *
     * @param $id
     * @return void
     */
    public function show($id)
    {

        $blog = Blog::find($id);
        if ($blog == null) {
            return view('error.404');
        }
        return view('admin/blog/detail-blog')->with('blog', $blog);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param \App\Blog $blog
     * @return \Illuminate\Http\Response
     */
    public function edit(Blog $blog)
    {
        return view('admin/blog/edit-blog')->with('blog', $blog);

    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $obj = Blog::findOrFail($id);
        $obj->title = $request->input('title');
        $obj->title = $request->input('category');
        $obj->detail = $request->input('detail');
        $obj->detail = $request->input('status');
        $obj->content = $request->input('contentcheck');
        $files = $request->file('thumbnail');
        $image_url = '';
        foreach ($files as $file) {
            $img = $file->getRealPath();
            Cloudder::upload($img, null);
            $image_url .= Cloudder::show(Cloudder::getPublicId());
        }
        $obj->thumbnail = $image_url;
        $obj->save();
        return redirect('admin/blog') ->withSuccess('sửa thành công');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\Blog $blog
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        error_log('Some message here.');
        $blog = Blog::find($id);
        $blog->status = -1;
        $blog->save();
        return response()->json(['status' => '200', 'message' => 'Okie']);
    }

    public function changeStatus(Request $request)
    {
        $listItem = Blog::whereIn('id', $request->input('ids'));
        $listItem->update(array(
            'status' => (int)$request->input('status'),
            'updated_at' => date('Y-m-d H:i:s')));
        return response()->json(['status' => '200', 'message' => 'Good']);
    }

}
