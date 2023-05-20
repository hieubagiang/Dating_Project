<?php

namespace App\Http\Controllers;

use App\Http\Requests\PT_Validate;
use App\PersonalTraining;
use Illuminate\Http\Request;
use JD\Cloudder\Facades\Cloudder;
use Illuminate\Support\Facades\DB;

class AdminPTController extends Controller
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

        $list = PersonalTraining::where('status', 1) ->paginate(10);
        $data = ['list' => $list];
        return view('admin.pt.list', $data);
    }

    public function index2()
    {
        $list = PersonalTraining::where('status', [-1,-2]) ->paginate(6);
        $data = ['list' => $list];
        return view('admin/pt/deleted-pt', $data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin.pt.form');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(PT_Validate $request)
    {
        $request->validated();
        $PersonalTraining = new PersonalTraining();
        $PersonalTraining->name = $request->get('name');
        $PersonalTraining->description = $request->get('description');
        $PersonalTraining->qualification = $request->get('qualification');
        $PersonalTraining->experience = $request->get('experience');
        $files = $request->file('image');
        $image_url = '';
        foreach ($files as $file) {
            $img = $file->getRealPath();
            Cloudder::upload($img, null);
            $image_url .= Cloudder::show(Cloudder::getPublicId());
        }
        $PersonalTraining->image = $image_url;
        $PersonalTraining->rating = $request->get('rating');
        $PersonalTraining->status = $request->get('status');
        $PersonalTraining->save();
        return redirect('admin/pt');
    }

    /**
     * Display the specified resource.
     *
     * @param $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $PersonalTraining = PersonalTraining::find($id);
        $data = ['PersonalTraining' => $PersonalTraining];
        return view('admin.pt.detail', $data);

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param \App\AdminPT $adminPT
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $PersonalTraining = PersonalTraining::find($id);
        $data = ['PersonalTraining' => $PersonalTraining];
        return view('admin.pt.edit', $data);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param \App\AdminPT $adminPT
     * @return \Illuminate\Http\Response
     */
    public function update(PT_Validate $request, $id)
    {
        $PersonalTraining = PersonalTraining::find($id);
        $request->validated();
        $PersonalTraining->name=$request->get('name');
        $PersonalTraining->description=$request->get('description');
        $PersonalTraining->qualification=$request->get('qualification');
        $PersonalTraining->experience=$request->get('experience');
        $files = $request->file('image');
        $image_url = '';
        foreach ($files as $file) {
            $img = $file->getRealPath();
            Cloudder::upload($img, null);
            $image_url .= Cloudder::show(Cloudder::getPublicId());
        }
        $PersonalTraining->image = $image_url;
        $PersonalTraining->rating=$request->get('rating');
        $PersonalTraining->status=$request->get('status');
        $PersonalTraining->save();
        return redirect('admin/pt');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\AdminPT $adminPT
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        error_log('Some message here.');
        $PersonalTraining = PersonalTraining::find($id);
        $PersonalTraining->status = -1;
        $PersonalTraining->save();
        return response()->json(['status' => '200', 'message' => 'Okie']);
    }

    public function changeStatus(Request $request)
    {
        $listItem = PersonalTraining::whereIn('id', $request->input('ids'));
        $listItem->update(array(
            'status' => (int)$request->input('status'),
            'updated_at' => date('Y-m-d H:i:s')));
        return response()->json(['status' => '200', 'message' => 'Good']);
    }
}
