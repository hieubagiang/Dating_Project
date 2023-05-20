<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;

class IndexBodyController extends Controller
{
    function getData(Request $request)
    {
        $data = $request->all();
        return view('client/index-body/index-body-3', $data);
    }

    function getResult(Request $request)
    {
        $data = $request->all();
        $weight = $request->get('weight');
        $height = $request->get('height');
        $age = $request->get('age');
        $training = $request->get('training');
        $week = $request->get('week');
        $next_weight = $request->get('next_weight');
        $date = $request->get('date');
        $bmr = (13.397 * $weight) + (4.799 * $height) - (5.677 * $age) + 88.362;
        if ($training == 0) {
            $calo = $bmr * 1.2;
        } else if ($training == 1) {
            $calo = $bmr * 1.375;
        } else if ($training == 2) {
            $calo = $bmr * 1.55;
        } else if ($training == 3) {
            $calo = $bmr * 1.725;
        }
        $calo = ceil($calo);
        if ($week == 0.5) {
            $down_calo = $calo - 300;
        } else if ($week == 1) {
            $down_calo = $calo - 500;
        }
        $time = (int)($next_weight / $week)*7;
        try {
            $start = new Carbon($date);
            $date = $start->addDays($time);
        } catch (\Exception $e) {
        }
        $down_calo = ceil($down_calo);
        $goal_weight = $weight - $next_weight;
        return view('client/index-body/index-body-4', compact('calo', 'down_calo', 'goal_weight','date'), $data);
    }
}
