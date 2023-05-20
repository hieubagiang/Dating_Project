<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PT_Validate extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'name' => 'required|max:50|min:2',
            'description' => 'required|max:500|min:10',
            'qualification' => 'required|max:500|min:10',
            'experience' => 'required|max:500|min:10',
            'rating' => 'required|max:5|min:2',
            'status' => 'required|max:1',
        ];
    }
    public function messages()
    {
        return [
            'name.min' => '*Tên của bạn quá ngắn, vui lòng nhập ít nhất 2 kí tự',
            'name.max' => '*Tên của bạn quá dài, vui lòng nhập nhiều nhất 50 kí tự',
            'name.required' => '*Vui lòng nhập tên của bạn.',
            'description.required'=>'*Vui lòng nhập description của bạn.',
            'description.min'=>'*Description của bạn quá ngắn, vui lòng nhập ít nhất 10 kí tự.',
            'description.max'=>'*Description của bạn quá dài, vui lòng nhập  nhất 500 kí tự.',
            'qualification.required'=>'*Vui lòng nhập qualification của bạn.',
            'qualification.min'=>'*Qualification của bạn quá ngắn, vui lòng nhập ít nhất 10 kí tự.',
            'qualification.max'=>'*Qualification của bạn quá dài, vui lòng nhập  nhất 500 kí tự.',
            'experience.required'=>'*Vui lòng nhập experience của bạn.',
            'experience.min'=>'*Experience của bạn quá ngắn, vui lòng nhập ít nhất 10 kí tự.',
            'experience.max'=>'*Experience của bạn quá dài, vui lòng nhập  nhất 500 kí tự.',
            'rating.required'=>'*Vui lòng nhập rating của bạn.',
            'rating.min'=>'*Rating của bạn quá ngắn, vui lòng nhập ít nhất 0 kí tự.',
            'rating.max'=>'*Rating của bạn quá dài, vui lòng nhập  nhất 5 kí tự.',
            'status.required'=>'*Vui lòng nhập status của bạn.',
            'status.max'=>'*Status của bạn quá dài, vui lòng nhập  nhất 5 kí tự.',
        ];
    }
}
