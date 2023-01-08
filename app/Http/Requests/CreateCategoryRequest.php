<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CreateCategoryRequest extends FormRequest
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
     * @return array<string, mixed>
     */
    public function rules()
    {
        $rules =  [
            'name' => 'required|regex:/[a-zA-Z ]/|unique:categories,name',
            'status' => 'required',
            'description' => 'required'
        ];

        if($this->getMethod()=='PUT'){
            $rules['name'] = 'required|regex:/[a-zA-Z ]/|unique:categories,name,'.$this->route('category')->id;
        }

        return $rules;
    }
}
