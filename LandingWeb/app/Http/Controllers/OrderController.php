<?php

namespace App\Http\Controllers;

use App\Duration;
use App\Order;
use App\personalTraining;
use App\User;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Mail;
use JD\Cloudder\Facades\Cloudder;

class OrderController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {
            $durationID = Duration::find($request->get('duration_id'));
            $order = new Order();
            $orderID = date("YmdHis");
            $order->id = $orderID;
            $order->user_id = $request->get('user_id');
            $order->personal_training_id = $request->get('personal_training_id');
            $order->personal_training_time_id = $request->get('personal_training_time_id');
            $order->duration_id = $durationID->id;
            $order->price = $durationID->price;
            $order->created_at = date('Y-m-d H:i:s');
            $order->updated_at = date('Y-m-d H:i:s');
            $order->save();
            $data = [
                'ptName' => $request->get('pt-name'),
                'duration' => $request->get('duration'),
                'time' => $request->get('time'),
                'price' => $request->get('price'),
                'orderID' => $orderID,
            ];
            return view('client.payment', $data);
        } catch (QueryException $e) {
            return view('404_error');
        }

    }

    /**
     * Display the specified resource.
     *
     * @param \App\Order $order
     * @return \Illuminate\Http\Response
     */
    public function show(Order $order)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param \App\Order $order
     * @return \Illuminate\Http\Response
     */
    public function edit(Order $order)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param \App\Order $order
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Order $order)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\Order $order
     * @return \Illuminate\Http\Response
     */
    public function destroy(Order $order)
    {
        //
    }

    public function createPayment(Request $request)
    {
        DB::beginTransaction();
        try {
            session(['cost_id' => $request->get('order_id')]);
            session(['url_prev' => url()->previous()]);
            $vnp_TmnCode = "Z1YPV5PL"; //Mã website tại VNPAY
            $vnp_HashSecret = "DUNDLUFVPSUAWWAWOTPPRTZIPIBBFWKJ"; //Chuỗi bí mật
            $vnp_Url = "http://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
            $vnp_Returnurl = "http://localhost:8000/return-vnpay";
            $vnp_TxnRef = $request->get('order_id'); //Mã đơn hàng. Trong thực tế Merchant cần insert đơn hàng vào DB và gửi mã này sang VNPAY
            $vnp_OrderInfo = "Thanh toán thuê huấn luyện viên";
            $vnp_OrderType = 'billpayment';
            $vnp_Amount = $request->get('amount') * 100;
            $vnp_Locale = $request->get('language');
            $vnp_IpAddr = request()->ip();
            $vnp_BankCode = $request->get('bank_code');

            $inputData = array(
                "vnp_Version" => "2.0.0",
                "vnp_TmnCode" => $vnp_TmnCode,
                "vnp_Amount" => $vnp_Amount,
                "vnp_Command" => "pay",
                "vnp_CreateDate" => date('YmdHis'),
                "vnp_CurrCode" => "VND",
                "vnp_IpAddr" => $vnp_IpAddr,
                "vnp_Locale" => $vnp_Locale,
                "vnp_OrderInfo" => $vnp_OrderInfo,
                "vnp_OrderType" => $vnp_OrderType,
                "vnp_ReturnUrl" => $vnp_Returnurl,
                "vnp_TxnRef" => $vnp_TxnRef,
            );
            if (isset($vnp_BankCode) && $vnp_BankCode != "") {
                $inputData['vnp_BankCode'] = $vnp_BankCode;
            }
            ksort($inputData);
            $query = "";
            $i = 0;
            $hashdata = "";
            foreach ($inputData as $key => $value) {
                if ($i == 1) {
                    $hashdata .= '&' . $key . "=" . $value;
                } else {
                    $hashdata .= $key . "=" . $value;
                    $i = 1;
                }
                $query .= urlencode($key) . "=" . urlencode($value) . '&';
            }

            $vnp_Url = $vnp_Url . "?" . $query;
            if (isset($vnp_HashSecret)) {
                // $vnpSecureHash = md5($vnp_HashSecret . $hashdata);
                $vnpSecureHash = hash('sha256', $vnp_HashSecret . $hashdata);
                $vnp_Url .= 'vnp_SecureHashType=SHA256&vnp_SecureHash=' . $vnpSecureHash;
            }
            $user_id = $request->get('user_id');
            $user = User::find($user_id);
            $email = $user->email;
            $this->send($email);
            DB::commit();
            echo('Vui lòng chờ thanh toán hóa đơn');
            die();
        } catch (\Exception $exception) {
            DB::rollBack();
            return view('done');
        }
    }

    public function return(Request $request)
    {
        $url = session('url_prev', '/');
        if ($request->vnp_ResponseCode == "00") {
            $this->apSer->thanhtoanonline(session('cost_id'));
            return redirect($url)->with('success', 'Đã thanh toán phí dịch vụ');
        }
        session()->forget('url_prev');
        return redirect($url)->with('errors', 'Lỗi trong quá trình thanh toán phí dịch vụ');
    }

    public function getChartDataApi()
    {
        $start_date = Input::get('startDate');
        $end_date = Input::get('endDate');
        $chart_data = Order::select(DB::raw('sum(price) as revenue'), DB::raw('date(created_at) as day'))
            ->whereRaw('created_at >= "' . $start_date . ' 00:00:00" AND created_at <= "' . $end_date . ' 23:59:59" AND status = 2')
            ->groupBy('day')
            ->orderBy('day', 'desc')
            ->get();
        return $chart_data;
    }

    public function getDataToTimeApi()
    {
        $start_date = Input::get('startDate');
        $end_date = Input::get('endDate');
        $orders = Order::select()
            ->whereBetween('orders.created_at', array($start_date . ' 00:00:00', $end_date . ' 23:59:59'))
            ->orderBy('created_at', 'desc')
            ->get();
        foreach ($orders as $data) {
            $data->statusLabel = $data->getStatusLabelAttribute();
        }
        return response()->json(['list_obj' => $orders], 200);
    }

    public function getPieChartDataApi()
    {
        //DB::connection()->enableQueryLog();
        $start_date = Input::get('startDate');
        $end_date = Input::get('endDate');
//        $chart_data = OrderDetail::select(DB::raw('sum(quantity) as totalQuantity'), DB::raw('product_id as product_id'))
//            ->whereRaw('created_at >= "'.$start_date.' 00:00:00" AND created_at <= "'.$end_date . ' 23:59:59"')
//            ->groupBy('product_id')
//            ->get();
        $orders = PersonalTraining::whereRaw('status=1')->get();
        $id = $orders->pluck('id')->all();
        $chart_data = Order::select(DB::raw('sum(personal_training_time_id) as totalQuantity'), 'personal_training_id')
            ->whereRaw('updated_at >= "' . $start_date . ' 00:00:00" AND updated_at <= "' . $end_date . ' 23:59:59"')
            ->whereIn('personal_training_id', $id)
            ->groupBy('personal_training_id')
            ->orderBy('totalQuantity', 'desc')
            ->get();
        return $chart_data;
    }

    public function send($email)
    {
        Mail::send(['text' => 'mail'], ['name', 'Phuong'], function ($message) use ($email) {
            $message->to($email)->subject('Thanh toán thành công!');
            $message->from('phuongtranthi@gmail.com', 'Phuong');
        });
    }
}
