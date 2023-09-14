require 'rails_helper'
RSpec.describe 'STEP5 ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }

  before do
    visit root_path
    fill_in 'session_email', with: 'admin1@example.com'
    fill_in 'session_password', with: 'admin1'
    click_on 'Log in'
    sleep 5
  end

  describe 'ラベルの登録' do
    context 'タスクを新規登録した時' do
      it 'ラベルの登録も一緒にできる' do

      end
    end
    context 'タスク一覧画面から' do
      it '編集画面にて、ラベルの編集ができる' do

      end
    end
  end

  describe 'ラベルの検索機能' do
    it 'ラベルの検索ができる' do

    end
    it '該当のラベルがない時、エラーメッセージが出る' do

    end
  end
end