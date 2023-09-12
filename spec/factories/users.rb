FactoryBot.define do
  factory :user do
    name { '管理者' }
    email { "admin1@example.com" }
    admin { true }
    password { 'admin1' }
  end

  factory :second_user, class: User do
    name { '一般ユーザー2' }
    email { "ippan2@example.com" }
    password { 'ippan2'}
  end

  factory :third_user, class: User do
    name { '一般ユーザー3' }
    email { "ippan3@example.com" }
    password { 'ippan3'}
  end
end
