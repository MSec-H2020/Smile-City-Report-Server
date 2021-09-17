# frozen_string_literal: true

FactoryBot.define do
  factory :theme do
    title { 'タイトル' }
    area { '地域名' }
    message { 'メッセージ' }
    public { true }
    facing { true }
    association :owner, factory: :user
  end
end
