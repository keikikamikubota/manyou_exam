FactoryBot.define do
  factory :task do
    name { 'タイトル1' }
    content { 'コンテント1' }
    expired_at { Time.current + 3.days }
    status { 0 }
    priority { 0 }
  end

  factory :second_task, class: Task do
    name { 'タイトル2' }
    content { 'コンテント2' }
    expired_at { Time.current + 4.days }
    status { 1 }
    priority { 1 }
  end

  factory :third_task, class: Task do
    name { 'タイトル3' }
    content { 'コンテント3' }
    expired_at { Time.current + 2.days }
    status { 1 }
    priority { 1 }
  end
end
