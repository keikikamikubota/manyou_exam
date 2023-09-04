FactoryBot.define do
  factory :task do
    name { 'Factoryで作ったタイトル1' }
    content { 'Factoryで作ったコンテント1' }
    expired_at { Time.current + 3.days }
  end

  factory :second_task, class: Task do
    name { 'Factoryで作ったタイトル2' }
    content { 'Factoryで作ったコンテント2' }
    expired_at { Time.current + 4.days }
  end
end
