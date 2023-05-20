<?php

use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $userRole = config('roles.models.role')::where('name', '=', 'User')->first();
        $adminRole = config('roles.models.role')::where('name', '=', 'admin')->first();
        $permissions = config('roles.models.permission')::all();

        /*
         * Add Users
         *
         */
        if (config('roles.models.defaultUser')::where('email', '=', 'phannam123@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 1,
                'firstName' => 'Phan',
                'lastName' => 'Hoài Nam',
                'phone' => '09123688762',
                'gender' => 0,
                'role_id' => 1,
                'email' => 'phannam123@gmail.com',
                'password' => bcrypt('123'),
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser->attachRole($adminRole);
            foreach ($permissions as $permission) {
                $newUser->attachPermission($permission);
            }
        }

        if (config('roles.models.defaultUser')::where('email', '=', 'phannamheot@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 2,
                'firstName' => 'Phạm',
                'lastName' => 'Văn Dung',
                'phone' => '09123688762',
                'gender' => 0,
                'role_id' => 4,
                'pt_id' => 1,
                'email' => 'phannamheot@gmail.com',
                'password' => bcrypt('123'),
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser->attachRole($adminRole);
            foreach ($permissions as $permission) {
                $newUser->attachPermission($permission);
            }
        }

        if (config('roles.models.defaultUser')::where('email', '=', 'beledat@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 3,
                'firstName' => 'Phùng',
                'lastName' => 'Hoa Đạt',
                'phone' => '0349872712',
                'gender' => 0,
                'email' => 'beledat@gmail.com',
                'password' => bcrypt('123'),
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'anhngoc@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 4,
                'firstName' => 'Lương',
                'lastName' => 'Anh Ngọc',
                'phone' => '0919123892',
                'gender' => 0,
                'email' => 'anhngoc@gmail.com',
                'password' => bcrypt('123'),
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'anhtuan@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 5,
                'firstName' => 'Lê',
                'lastName' => 'Tuấn Anh',
                'phone' => '09128391283',
                'gender' => 0,
                'email' => 'anhtuan@gmail.com',
                'password' => '123',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'vuanh@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 6,
                'firstName' => 'Phan',
                'lastName' => 'Vũ Anh',
                'phone' => '0192318782',
                'gender' => 1,
                'email' => 'vuanh@gmail.com',
                'password' => '123',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'thanhnga91238@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 7,
                'firstName' => 'Hoàng',
                'lastName' => 'Thanh Nga',
                'phone' => '023891237372',
                'gender' => 1,
                'email' => 'thanhnga91238@gmail.com',
                'password' => '9123',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'hely92139@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 8,
                'firstName' => 'Vũ',
                'lastName' => 'Phương Ly',
                'phone' => '09123688762',
                'gender' => 1,
                'email' => 'hely92139@gmail.com',
                'password' => '456',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'huong98123@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 9,
                'firstName' => 'Nguyễn',
                'lastName' => 'Hương Dương',
                'phone' => '098123767312',
                'gender' => 0,
                'email' => 'huong98123@gmail.com',
                'password' => '123',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'hoangnam19827@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 10,
                'firstName' => 'Nguyễn',
                'lastName' => 'Hoàng Nam',
                'phone' => '03517238992',
                'gender' => 0,
                'email' => 'hoangnam19827@gmail.com',
                'password' => '987',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'phan123@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 11,
                'firstName' => 'Phan',
                'lastName' => 'Xào Nam',
                'phone' => '09123688762',
                'gender' => 0,
                'email' => 'phan123@gmail.com',
                'password' => '123',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'phuonganh12673@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 12,
                'firstName' => 'Đào',
                'lastName' => 'Phương Anh',
                'phone' => '091238193104',
                'gender' => 1,
                'email' => 'phuonganh12673@gmail.com',
                'password' => '123',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'lyphuong1188@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 13,
                'firstName' => 'Nguyễn',
                'lastName' => 'Hoàng Phương Ly',
                'phone' => '0128378123',
                'gender' => 1,
                'email' => 'lyphuong1188@gmail.com',
                'password' => '1923',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
        if (config('roles.models.defaultUser')::where('email', '=', 'duongpa998877@gmail.com')->first() === null) {
            $newUser = config('roles.models.defaultUser')::create([
                'id' => 14,
                'firstName' => 'Dương',
                'role_id' =>4,
                'lastName' => 'Phương Anh',
                'phone' => '0918213662144',
                'gender' => 1,
                'email' => 'duongpa998877@gmail.com',
                'password' => '123',
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ]);

            $newUser;
            $newUser->attachRole($userRole);
        }
    }
}
