<?php

namespace App\Http\Controllers;

use App\Duration;
use Illuminate\Http\Request;

class DurationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $duration = Duration::whereNotIn('status', [-1])->paginate(10);
        $data = ['duration' => $duration];
        return view('admin.duration.list-duration',$data);
    }

    public function index2()
    {
        $duration = Duration::whereNotIn('status', [1]) ->paginate(10);
        $data = ['duration' => $duration];
        return view('admin.duration.deleted-duration', $data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin.duration.create-duration');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $duration = new Duration();
        $duration->price=$request->get('price');
        $duration->duration=$request->get('duration');
        $duration->save();
        return redirect('admin/duration');
    }

    /**
     * Display the specified resource.
     *
     * @param $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $duration = Duration::find($id);
        $data = ['duration' => $duration];
        return view('admin.duration.list-duration', $data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param $id
     * @return void
     */
    public function edit($id)
    {
        $duration = Duration::find($id);
        $data = ['duration' => $duration];
        return view('admin.duration.edit-duration', $data);
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
        $duration = Duration::find($id);
        $duration->price = $request->get('price');
        $duration->duration = $request->get('duration');
        $duration->save();
        return redirect('admin/duration');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Duration  $duration
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        error_log('Some message here.');
        $duration = Duration::find($id);
        $duration->status = -1;
        $duration->save();
        return response()->json(['status' => '200', 'message' => 'Okie']);
    }

    public function changeStatus(Request $request)
    {
        $listItem = Duration::whereIn('id', $request->input('ids'));
        $listItem->update(array(
            'status' => (int)$request->input('status'),
            'updated_at' => date('Y-m-d H:i:s')));
        return response()->json(['status' => '200', 'message' => 'Good']);
    }
}
