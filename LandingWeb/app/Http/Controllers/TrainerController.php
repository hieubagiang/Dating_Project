<?php


namespace App\Http\Controllers;
use App\Category;
use App\Order;
use App\PersonalTraining;
use App\PersonalTrainingCategory;
use App\PersonalTrainingTime;
use App\Time;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\UploadedFile;
use Illuminate\Http\File;


class TrainerController extends Controller
{

    public function getList()
    {
        if (Auth::user()->role_id !=4 ) {
            return redirect()->route('home');
        } else {
            if (Auth::user()->pt_id == 0) {
                return redirect()->route('trainer.get_register');
            }
        }
        $orders = Order::all()->where('personal_training_id', Auth::user()->trainer->id)
                            ->wherein('status', [2,3]);
        return view('trainer/list')->with(compact('orders'));

    }

    public function getOldList()
    {
        $orders = Order::all()->where('personal_training_id', Auth::user()->trainer->id)
            ->where('status',-2);
        return view('trainer/old_list')->with(compact('orders'));

    }

    public function getRegister(Request $request)
    {
        if (Auth::user()->pt_id == 1) {
            return route('home');
        }
        $times = Time::all();
        $categories = Category::all();
        return view('trainer.register')->with(compact('times','categories'));
    }

    public function postRegister(Request $request)
    {
        $data = $request->all();
        try {
            DB::beginTransaction();
            $trainer = new PersonalTraining();
            $trainer->user_id = Auth::id();
            $trainer->name = $data['nickname'];
            $trainer->description = $data['description'];
            $trainer->qualification = $data['qualification'];
            $trainer->experience = $data['experience'];
            $trainer->rating = 0;
            $trainer->status = 1;
            $name = $request->user()->id . '.png';
            Storage::putFileAs('', $data['file'], $name);
            $trainer->image = Storage::url($name);
            $trainer->save();
            foreach ($data['time'] as $time) {
                $personalTrainingTime = new PersonalTrainingTime();
                $personalTrainingTime->time_id = $time;
                $personalTrainingTime->personal_training_id = $trainer->id;
                $personalTrainingTime->status = 1;
                $personalTrainingTime->save();
            }
            foreach ($data['category'] as $category) {
                $personalTrainingCategory = new PersonalTrainingCategory();
                $personalTrainingCategory->category_id = $category;
                $personalTrainingCategory->personal_training_id = $trainer->id;
                $personalTrainingCategory->save();
            }

            Auth::user()->pt_id = 1;
            Auth::user()->save();
            DB::commit();
        } catch (QueryException $e) {
            DB::rollBack();
            return view('404_error');
        }
        return redirect()->route('home.trainer');

    }

    public function deleteByTrainer(Request $request)
    {
        $order = Order::find($request->id);
        $order->status = -2;
        $order->update();
        return redirect()->route('trainer.old_list');
    }

    public function acceptByTrainer(Request $request)
    {
        $order = Order::find($request->id);
        $order->status = 3;
        $order->update();
        return redirect()->route('home.trainer');
    }
}
