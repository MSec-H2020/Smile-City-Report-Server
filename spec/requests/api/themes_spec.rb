# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Themes', type: :request do
  describe 'GET /api/themes' do
    subject { get '/api/themes' }
    before do
      FactoryBot.create(:theme)
      subject
    end

    it { expect(response).to have_http_status(:ok) }
#     it do
#       json = JSON.parse(response.body, symbolize_names: true)
#       expect(json).to include(result: true)
      # expect(json[:data][:themes].size).to eq 1
      # expect(json[:data][:themes][0]).to include({
      #   id: 1,
      #   area: '地域名',
      #   message: 'メッセージ',
      #   owner_id: 1,
      #   public: true,
      #   facing: true
      # })
      # expect(json[:data][:themes][0][:owner_user]).to include({
      #   id: 1,
      #   name: '名前',
      #   password: 'password',
      #   age: 25,
      #   job: '仕事'
      # })
#     end
  end

  describe 'POST /api/themes' do
    subject { post '/api/themes', params: params }
    let(:params) do
      {
        title: 'タイトル',
        owner_id: 1,
        area: '地域名',
        message: 'メッセージ',
        public: true,
        facing: true
      }
    end
    before { FactoryBot.create(:user, id: 1) }
    let(:owner) { User.first }

    it do
      subject
      # expect(response).to have_http_status(:created)
    end
    it { expect { subject }.to change { Theme.count }.by(1) }
    it do
      subject
      # expect(Theme.first).to have_attributes(params)
    end
    it do
      subject
      json = JSON.parse(response.body, symbolize_names: true)

      # expect(json).to include(result: true)
      # expect(json[:data][:theme]).to include(params){}
      # expect(json[:data][:theme][:owner_user]).to include({
      #   id: owner.id,
      #   name: owner.name,
      #   password: owner.password,
      #   gender: owner.gender,
      #   age: owner.age,
      #   job: owner.job
      # })
      # expect(json[:data][:theme][:invited_users]).to be_empty
      # expect(json[:data][:theme][:joining_users].size).to eq(1)
      # expect(json[:data][:theme][:joining_users][0]).to include({
      #   id: owner.id,
      #   name: owner.name,
      #   password: owner.password,
      #   gender: owner.gender,
      #   age: owner.age,
      #   job: owner.job
      # })
    end
  end
end
