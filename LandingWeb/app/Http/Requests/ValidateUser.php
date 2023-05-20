<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ValidateUser extends FormRequest
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
            'firstName' => 'required|max:30|min:2',
            'lastName' => 'required|max:30|min:2',
            'phone' => 'required|max:12|min:6',
            'email' => 'required|email|max:30|min:5',
            'gender' => 'required',
            'password' => 'required|max:300|min:6',
//            'password_confirmation' => 'required_with:password|same:password|min:5|max:15'
        ];
    }

    public function messages()
    {
        return [
            'firstName.min' => '*Họ của bạn quá ngắn, vui lòng nhập ít nhất 2 kí tự',
            'firstName.max' => '*Họ của bạn quá dài, vui lòng nhập nhiều nhất 20 kí tự',
            'firstName.required' => '*Vui lòng nhập tên của bạn.',
            'lastName.required' => '*Vui lòng nhập họ của bạn',
            'lastName.min' => '*Tên của bạn quá ngắn, vui lòng nhập ít nhất 2 kí tự',
            'lastName.max' => '*Tên của bạn quá dài, vui lòng nhập nhiều nhất 20 kí tự',
            'phone.required' => '*Vui lòng nhập số điện thoại của bạn',
            'phone.max' => '*Số điện thoại không hợp lệ, vui lòng thử lại.',
            'phone.min' => '*Số điện thoại không hợp lệ, vui lòng thử lại.',
            'email.required' => '*Vui lòng nhập email của bạn',
            'email.email' => '*Vui lòng nhập email của bạn theo đúng định dạng',
            'email.max' => '*Địa chỉ email không được dài quá 30 kí tự.',
            'email.min' => '*Địa chỉ email không được ngắn quá 30 kí tự.',
            'gender.required' => '*Vui lòng lựa  chọn giới tính của bạn',
            'password.required' => '*Vui lòng nhập password của bạn',
            'password.min' => '*Password của bạn quá ngắn, vui lòng nhập ít nhất 6 kí tự',
            'password.max' => '*Password của bạn quá dài, vui lòng nhập nhiều nhất 30 kí tự',
            'password_confirmation.required_with' => '*Vui lòng nhập comfirm_password của bạn',
        ];
    }
}
