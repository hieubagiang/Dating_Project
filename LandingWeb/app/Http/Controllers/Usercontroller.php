<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateUserAdminRequest;
use App\Http\Requests\ValidateUser;
use App\Order;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class Usercontroller extends Controller
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
        $list = User::whereNotIn('status', [-1])->paginate(10);
        $data = ['list' => $list];
        return view('admin.user.list-user',$data);
    }

    public function index2()
    {
        $list = User::whereNotIn('status', [1]) ->paginate(10);
        $data = ['list' => $list];
        return view('admin.user.deleted-user', $data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin.user.create-user');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(CreateUserAdminRequest $request)
    {
        $request ->validated();
        $user = new User();
        $user->firstName = $request->get('firstName');
        $user->lastName = $request->get('lastName');
        $user->phone = $request->get('phone');
        $user->gender = $request->get('gender');
        $user->email = $request->get('email');
        $user->password = $request->get('password');
        $user->save();
        return redirect('admin/user');
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $user = User::find($id);
        $data = ['user' => $user];
        return view('admin.user.list-user', $data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit(User $user)
    {
        return view('admin/user/edit-user')->with('user', $user);

    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(ValidateUser $request, $id)
    {
        $user=User::find($id);
        $request->validated();
        $request->validate([
            'firstName' => 'required|max:20|min:2',
            'lastName' => 'required|max:20|min:2',
            'phone' => 'required',
            'email' => 'required|email|unique:users,email',
            'gender' => 'required',
            'password' => 'required|max:15|min:5',
        ],
            [
                'firstName.required'=>'Vui lòng nhập họ của bạn',
                'firstName.min'=>'Họ của bạn quá ngắn, vui lòng nhập ít nhất 2 kí tự',
                'firstName.max'=>'Họ của bạn quá dài, vui lòng nhập nhiều nhất 20 kí tự',
                'lastName.required'=>'Vui lòng nhập họ của bạn',
                'lastName.min'=>'Họ của bạn quá ngắn, vui lòng nhập ít nhất 2 kí tự',
                'lastName.max'=>'Họ của bạn quá dài, vui lòng nhập nhiều nhất 20 kí tự',
                'phone.required'=>'Vui lòng nhập số điện thoại của bạn',
                'email.required'=>'Vui lòng nhập email của bạn',
                'email.email'=>'Vui lòng nhập email của bạn theo đúng định dạng',
                'email.unique'=>'Email đã được sử dụng, vui lòng chọn email khác',
                'gender.required'=>'Vui lòng lựa  chọn giới tính của bạn',
                'password.required'=>'Vui lòng nhập password của bạn',
                'password.min'=>'Password của bạn quá ngắn, vui lòng nhập ít nhất 5 kí tự',
                'password.max'=>'Password của bạn quá dài, vui lòng nhập nhiều nhất 15 kí tự',
            ]);
        $user->firstName = $request->get('firstName');
        $user->lastName = $request->get('lastName');
        $user->phone = $request->get('phone');
        $user->gender = $request->get('gender');
        $user->email = $request->get('email');
        $user->password = $request->get('password');
        $user->save();
        return redirect('/admin/user');
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
        $user = User::find($id);
        $user->status = -1;
        $user->save();
        return response()->json(['status' => '200', 'message' => 'Okie']);
    }

    public function changeStatus(Request $request)
    {
        $listItem = User::whereIn('id', $request->input('ids'));
        $listItem->update(array(
            'status' => (int)$request->input('status'),
            'updated_at' => date('Y-m-d H:i:s')));
        return response()->json(['status' => '200', 'message' => 'Good']);
    }

    public function getClassroom() {
        $orders = Order::all()->where('user_id', Auth::user()->id);
        return view('client/classroom')->with(compact('orders'));
    }
}
