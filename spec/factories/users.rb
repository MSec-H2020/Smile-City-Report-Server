# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { '名前' }
    email { 'user@example.com' }
    nickname { 'ニックネーム' }
    password { 'password' }
    gender { 1 }
    age { 25 }
    job { '仕事' }
  end
end
