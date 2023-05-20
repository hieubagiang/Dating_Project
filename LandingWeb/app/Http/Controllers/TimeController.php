<?php

namespace App\Http\Controllers;

use App\time;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class TimeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        $time = Time::whereNotIn('status', [-1])->paginate(10);
        $data = ['time' => $time];
        return view('admin.time.list-time',$data);
    }


    public function index2()
    {
        $time = Time::whereNotIn('status', [1]) ->paginate(10);
        $data = ['time' => $time];
        return view('admin.time.deleted-time', $data);
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create()
    {
        return view('admin.time.create-time');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        $time = new Time();
        $time->time =$request->get('time');
        $time->save();
        return redirect('admin/time');
    }

    /**
     * Display the specified resource.
     *
     * @param $id
     * @return Response
     */
    public function show($id)
    {
        $time = Time::find($id);
        $data = ['time' => $time];
        return view('admin.time.list-time', $data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param $id
     * @return Response
     */
    public function edit($id)
    {
        $time = Time::find($id);
        $data = ['time' => $time];
        return view('admin.time.edit-time', $data);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param time $time
     * @param $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        $time = Time::find($id);
        $time->time = $request->get('time');
        $time->save();
        return redirect('admin/time');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param $id
     * @return Response Api
     */
    public function destroy($id)
    {
        error_log('Some message here.');
        $time = Time::find($id);
        $time->status = -1;
        $time->save();
        return response()->json(['status' => '200', 'message' => 'Okie']);
    }

    public function changeStatus(Request $request)
    {
        $listItem = Time::whereIn('id', $request->input('ids'));
        $listItem->update(array(
            'status' => (int)$request->input('status'),
            'updated_at' => date('Y-m-d H:i:s')));
        return response()->json(['status' => '200', 'message' => 'Good']);
    }
}
