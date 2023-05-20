<?php

namespace App\Http\Controllers;


use App\Category;
use Illuminate\Http\Request;

class AdminCategoryController extends Controller
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
        $category = Category::whereNotIn('status', [-1]) ->paginate(5);
        $data = ['category' => $category];
        return view('admin.category.list-category', $data);
    }

    public function index2()
    {
        $category = Category::whereNotIn('status', [1]) ->paginate(5);
        $data = ['category' => $category];
        return view('admin.category.deleted-category', $data);
    }



    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin.category.create-category');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $adCategory = new Category();
        $adCategory->name = $request->get('name');
        $adCategory->save();
        return redirect('admin/category');
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $adCategory = Category::find($id);
        $data = ['adCategory' => $adCategory];
        return view('admin.category.list-category', $data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $adCategory = Category::find($id);
        $data = ['adCategory' => $adCategory];
        return view('admin.category.edit-category', $data);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $adCategory = Category::find($id);
        $adCategory->name = $request->get('name');
        $adCategory->save();
        return redirect('admin/category');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        error_log('Some message here.');
        $adCategory = Category::find($id);
        $adCategory->status = -1;
        $adCategory->save();
        return response()->json(['status' => '200', 'message' => 'Okie']);
    }

    public function changeStatus(Request $request)
    {
        $listItem = Category::whereIn('id', $request->input('ids'));
        $listItem->update(array(
            'status' => (int)$request->input('status'),
            'updated_at' => date('Y-m-d H:i:s')));
        return response()->json(['status' => '200', 'message' => 'Good']);
    }
}
