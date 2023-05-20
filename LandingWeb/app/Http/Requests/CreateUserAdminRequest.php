<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CreateUserAdminRequest extends FormRequest
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
            'email' => 'required|email|unique:users,email',
            'gender' => 'required',
            'password' => 'required|max:30|min:6',
        ];
    }

    public function messages()
    {
        return [
            'firstName.required' => '*Vui lòng nhập họ người dùng.',
            'firstName.min' => '*Họ quá ngắn, vui lòng nhập ít nhất 2 kí tự.',
            'firstName.max' => '*Họ quá dài, vui lòng nhập nhiều nhất 30 kí tự.',
            'lastName.required' => '*Vui lòng nhập tên người dùng.',
            'lastName.min' => '*Tên quá ngắn, vui lòng nhập ít nhất 2 kí tự.',
            'lastName.max' => '*Tên quá dài, vui lòng nhập nhiều nhất 30 kí tự.',
            'phone.required' => '*Vui lòng nhập số điện thoại người dùng.',
            'phone.min' => '*Số điện thoại không hợp lệ, vui lòng thử lại.',
            'phone.max' => '*Số điện thoại không hợp lệ, vui lòng thử lại.',
            'gender.required' => '*Vui lòng chọn giới tính.',
            'email.required' => '*Vui lòng nhập địa chỉ email người dùng.',
            'email.unique' => '*Địa chỉ email đã tồn tại.',
            'email.min' => '*Địa chỉ Email quá ngắn, vui lòng nhập ít nhất 6 kí tự.',
            'email.max' => '*Địa chỉ Email quá dài, vui lòng nhập nhiều nhất 30 kí tự.',
            'password.required' => '*Vui lòng nhập mật khẩu người dùng',
            'password.min' => '*Mật khẩu quá ngắn, vui lòng nhập ít nhất 6 kí tự.',
            'password.max' => '*Mật khẩu quá dài, vui lòng nhập nhiều nhất 30 kí tự.',

        ];
    }
}
