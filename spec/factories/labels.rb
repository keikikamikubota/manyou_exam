FactoryBot.define do
  factory :label do
    title { "ラベル1" }
  end

  factory :second_label, class: Label do
    title { "事前登録済ラベル" }
  end

  factory :third_label, class: Label do
    title { "ラベル3" }
  end
end