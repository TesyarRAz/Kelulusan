<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\User;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        Role::query()->insert([
            [
                'name' => 'admin',
                'guard_name' => 'web',
            ],
            [
                'name' => 'student',
                'guard_name' => 'web',
            ],
        ]);

        $admin = User::query()->create([
            'name' => 'Admin',
            'email' => 'admin@localhost.com',
            'password' => bcrypt('password'),
        ]);

        $admin->assignRole('admin');
    }
}
