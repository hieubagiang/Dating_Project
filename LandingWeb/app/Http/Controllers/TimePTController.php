<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TimePTController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $time_pt = DB::table('personal_training_time')
            ->whereNotIn('status', [-1]) -> paginate(5);
        $data = ['time_pt' => $time_pt];
        return view('admin.time-pt.list-time-pt', $data);
    }
    public function index2()
    {
        $time_pt =DB::table('personal_training_time')->whereNotIn('status', [1]) ->paginate(5);
        $data = ['time_pt' => $time_pt];
        return view('admin.time-pt.deleted-time-pt', $data);
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin.time-pt.create-time-pt');
    }
    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $time_pt =  DB::table('personal_training_time');
        $time_pt->time_id = $request->get('time_id');
        $time_pt->personal_training_id = $request->get('personal_training_id');
        $time_pt->save();
        return redirect('admin/time-pt');
    }
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $time_pt = DB::table('personal_training_time')->find($id);
        $data = ['time_pt' => $time_pt];
        return view('admin.time-pt.list-time-pt', $data);
    }
    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $time_pt = DB::table('personal_training_time')->find($id);
        $data = ['time_pt' => $time_pt];
        return view('admin.time-pt.edit-time-pt', $data);
    }
    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {

        $time_id= $request->get('time_id');
        $personal_training_id = $request->get('personal_training_id');
        $status = $request->get('status');
        DB::table('personal_training_time')
            ->where('id',$id)
            ->update([
                'time_id' => $time_id,
                'personal_training_id'=>$personal_training_id,
                'status'=>$status,

                ]);
        return redirect('admin/time-pt');
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DB::table('personal_training_time')->where('id',$id)->update(['status' => -1]);
        return response()->json(['status' => '200', 'message' => 'Okie']);
    }

    public function changeStatus(Request $request)
    {
        $time_pt = DB::table('personal_training_time')->whereIn('id', $request->input('ids'));
        $time_pt->update(array(
            'status' => (int)$request->input('status'),
            'updated_at' => date('Y-m-d H:i:s')));
        return response()->json(['status' => '200', 'message' => 'Good']);
    }
}
