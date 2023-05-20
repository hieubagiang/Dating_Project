<?php

namespace App\Http\Controllers;

use App\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;


class AdminOrderController extends Controller
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

    public function index(Request $request)
    {
        $personal_training_id = Input::get('personal_training_id');
        $created_at = Input::get('created_at');
        $status = Input::get('status');
        $orders = Order::with('user', 'duration', 'personal_training')
            ->where('status', 2)
            ->orderBy('created_at', 'desc');
        if ($personal_training_id != null) {
            $orders = $orders->where('personal_training_id', $personal_training_id);
        } else {
            $personal_training_id = null;
        }
        if ($created_at != null) {
            $orders = $orders->where('created_at', $created_at);
        } else {
            $created_at = null;
        }
        if ($status != null) {
            $orders = $orders->where('status', $status);
        } else {
            $status = null;
        }
        $start_date = Input::get('startDate');
        $end_date = Input::get('endDate');
        if ($start_date != null && $end_date != null) {
            $orders = $orders->whereRaw('created_at >= "' . $start_date . ' 00:00:00" AND created_at <= "' . $end_date . ' 23:59:59" AND status = 2');
        } else {
            $start_date = null;
            $end_date = null;
        }
        $orders = $orders->paginate(10);
        $currentPersonalTrainingID = $request->get('personal_training_id');
        $currentCreated_at = $request->get('created_at');
        return view('admin.order.order-success', compact('orders', 'currentPersonalTrainingID', 'currentCreated_at'));
    }

    public function index2()
    {
        $orders = Order::where('status', [-1])
                        ->orWhere('status', [-2])->paginate(10);
        $data = ['orders' => $orders];
        return view('admin.order.deleted-order', $data);
    }

    public function index3()
    {
        $orders = Order::where('status', 1)->paginate(10);
        $data = ['orders' => $orders];
        return view('admin.order.list-order', $data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin.order.create-order');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $orders = new Order();
        $orders->user_id = $request->get('user_id');
        $orders->personal_training_id = $request->get('personal_training_id');
        $orders->personal_training_time_id = $request->get('personal_training_time_id');
        $orders->duration_id = $request->get('duration_id');
        $orders->price = $request->get('price');
        $orders->save();
        return redirect('admin/orders');
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $orders = Order::find($id);
        $data = ['orders' => $orders];
        return view('admin.order.list-order', $data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $orders = Order::find($id);
        $orders->status = 2;
        $orders->save();
        $time = DB::table('personal_training_time')->where('id', $orders->personal_training_time_id);
        $time->update(array(
            'status' => 0,
            'updated_at' => date('Y-m-d H:i:s')));
        return redirect()->back()->withSuccess('Phê duyệt thành công');
    }

    public function edit2($id)
    {
        $orders = Order::find($id);
        $orders->status = 1;
        $orders->save();
        return redirect()->back()->withSuccess('Phê duyệt thành công');
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $orders = Order::find($id);
        $orders->user_id = $request->get('user_id');
        $orders->personal_training_id = $request->get('personal_training_id');
        $orders->personal_training_time_id = $request->get('personal_training_time_id');
        $orders->duration_id = $request->get('duration_id');
        $orders->price = $request->get('price');
        $orders->save();
        return redirect('admin/orders');
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
        $orders = Order::find($id);
        $orders->status = -1;
        $orders->save();
        return response()->json(['status' => '200', 'message' => 'Okie']);
    }


    public function changeStatus(Request $request)
    {
        $listItem = Order::whereIn('id', $request->input('ids'));
        $listID = DB::table('orders')
            ->whereIn('id', $request->input('ids'))
            ->select('personal_training_time_id');
        $listTime = DB::table('personal_training_time')->whereIn('id', $listID);
        $listItem->update(array(
            'status' => $request->input('status'),
            'updated_at' => date('Y-m-d H:i:s')));
        $listTime->update(array(
            'status' => 0,
            'updated_at' => date('Y-m-d H:i:s')));
        return response()->json(['status' => '200', 'message' => 'Good']);
    }
}
