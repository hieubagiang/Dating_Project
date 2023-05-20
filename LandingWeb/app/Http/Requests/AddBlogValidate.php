<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AddBlogValidate extends FormRequest
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
            'category' => 'required|min:3|max:50',
            'title' => 'required|min:3|max:100',
            'detail' => 'required|min:10|max:255',
            'thumbnail' => 'required',
        ];
    }

    public function messages()
    {
      return[
          'category.required' => '*Vui lòng nhập tên danh mục.',
          'category.min' => '*Tên danh mục không được ngắn hơn 3 kí tự.',
          'category.max' => '*Tên danh mục không được dài quá 50 kí tự.',
          'title.required' => '*Vui lòng nhập tiêu đề.',
          'title.min' => '*Tiêu đề không được ngắn hơn 3 kí tự.',
          'title.max' => '*Tiêu đề không được dài quá 100 kí tự.',
            'detail.required' => '*Vui lòng nhập chi tiết.',
          'detail.min' => '*Chi tiết không được ngắn hơn 10 kí tự.',
          'detail.max' => '*Chi tiết không được dài quá 255 kí tự.',
          'thumbnail.required' => '*Vui lòng chọn ảnh.',
      ];
    }
}
