<?php

namespace App\Http\Controllers;


use App\Category;
use App\Duration;
use App\personalTraining;
use App\Review;
use App\Time;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;

class PersonalTrainingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function index(Request $request)
    {
        $list = PersonalTraining::where('status', 1);
        $orderBy = Input::get('orderBy');
        if ($orderBy == 'rate') {
            $list = $list->orderBy('rating', 'asc');
        } else if ($orderBy == 'date') {
            $list = $list->orderBy('created_at', 'desc');
        } else {
            $orderBy = null;
        }
        $list = $list->paginate(20);
        $currentOrderBy = $request->get('orderBy');
        return view('client/list-pt', compact('list','currentOrderBy'));
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
        //
    }

    /**
     * Display the specified resource.
     *
     * @param \App\personalTraining $personalTraining
     * @return \Illuminate\Http\Response
     */
    public function show(personalTraining $personalTraining)
    {
        $list = DB::table('categories')
            ->join('personal_training_category', function ($join) use ($personalTraining) {
                $join->on('categories.id', '=', 'personal_training_category.category_id')
                    ->where('personal_training_category.personal_training_id', $personalTraining->id);
            })
            ->get();
        $times = DB::table('times')
            ->join('personal_training_time', function ($join) use ($personalTraining) {
                $join->on('times.id', '=', 'personal_training_time.time_id')
                    ->where('personal_training_time.personal_training_id', $personalTraining->id);
            })
            ->get();
        $durations = Duration::all();
        $review = Review::with('personal_training','user') ->where('status',1)->where('personal_training_id',$personalTraining->id)->get();

        return view('client.pt-detail', compact('personalTraining', 'list', 'times','durations','review'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param \App\personalTraining $personalTraining
     * @return \Illuminate\Http\Response
     */
    public function edit(personalTraining $personalTraining)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param \App\personalTraining $personalTraining
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, personalTraining $personalTraining)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\personalTraining $personalTraining
     * @return \Illuminate\Http\Response
     */
    public function destroy(personalTraining $personalTraining)
    {
        //
    }
}
