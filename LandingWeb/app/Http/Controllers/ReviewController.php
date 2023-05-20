<?php

namespace App\Http\Controllers;

use App\Review;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ReviewController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     *
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $review = Review::with('personal_training', 'user')->where('status', 0)->paginate(8);
        return view('admin/review', compact('review'));

    }

    public function index2()
    {
        $review_success = Review::with('personal_training', 'user')->where('status', 1)->paginate(5);

        return view('admin/review-success', compact('review_success'));

    }

    public function index3()
    {
        $reviewdelete = Review::with('personal_training', 'user')->where('status', -1)->paginate(5);

        return view('admin/review-deleted', compact('reviewdelete'));

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

        $review = new Review();
        $review->user_id = auth()->user()->id;
        $pt_id = $request->get('personalTraining-id');
        $review->personal_training_id = $pt_id;
        $review->rating = (string)((double)$request->get('rate') / 5 * 100);
        $review->review = $request->get('review');
        $review->save();
        return redirect()->back()->withSuccess('Đã gửi đánh giá');

    }

    /**
     * Display the specified resource.
     *
     * @param \App\Review $review
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {

    }

    public function getById($id)
    {
        $reviewshow = Review::find($id);
        return response()->json(['status' => '200', 'message' => 'Okie', 'data' => $reviewshow]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $review = Review::findOrFail($id);
        $review->status = 1;
        $date = Carbon::now()->toDateTimeString();
        $review->deleted_at = $date;
        $review->save();
        $current_review = DB::table('reviews');
        $total_rating = $current_review->whereRaw('status = 1 and personal_training_id = ' . $review->personal_training_id)->sum('rating');
        $count_rating = $current_review->where('personal_training_id', $review->personal_training_id)->count();
        $current_rating = $total_rating / $count_rating;
        DB::table('personal_trainings')->where('id', $review->personal_training_id)->update(['rating' => $current_rating]);
        return redirect()->back()->withSuccess('Phê duyệt thành công');
    }

    public function changeStatus(Request $request)
    {
        $review = Review::whereIn('id', $request->input('ids'));
        $review->update(array(
            'status' => (int)$request->input('status'),
            'updated_at' => date('Y-m-d H:i:s')));
        return redirect()->back()->withSuccess('Thao tác giá thành công');
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param $id
     * @return void
     */
    public function update(Request $request, $id)
    {

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $review = Review::findOrFail($id);
        $review->status = -1;
        $date = Carbon::now()->toDateTimeString();
        $review->deleted_at = $date;
        $review->save();
        return redirect()->back()->withSuccess('Xoá đánh giá thành công');
    }

    public function edit2(Review $review)
    {
        $review = Review::findOrFail($review->id);
        $review->status = 0;
        $date = Carbon::now()->toDateTimeString();
        $review->deleted_at = $date;
        $review->save();
        return redirect()->back()->withSuccess('Khôi phục thành công');
    }

}
