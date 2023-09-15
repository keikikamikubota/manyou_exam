require 'rails_helper'
RSpec.describe 'STEP5 ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:label) { FactoryBot.create(:label)}
  let!(:second_label) { FactoryBot.create(:second_label)}

  before do
    visit root_path
    fill_in 'session_email', with: 'admin1@example.com'
    fill_in 'session_password', with: 'admin1'
    click_on 'Log in'
    sleep 1
    visit new_task_path
    fill_in 'task_name', with: 'テスト2'
    check '事前登録済ラベル'
    click_on '登録する'
    sleep 1
  end

  describe 'ラベルの登録' do
    context 'タスクを新規登録した時' do
      it 'ラベルの登録も一緒にできる' do
        visit new_task_path
        fill_in 'task_name', with: 'テスト1'
        check 'ラベル1'
        click_on '登録する'
        expect(page).to have_checked_field('ラベル1')
      end
    end
    context 'タスク一覧画面から' do
      it '編集画面にて、ラベルの編集ができる' do
        edit_task_path(task)
        check 'ラベル1'
        uncheck '事前登録済ラベル'
        click_on '登録する'
        expect(page).to have_checked_field('ラベル1')
        expect(page).not_to have_checked_field('事前登録済ラベル') #二つexpect書いてより精度を上げた
      end
    end
  end

  describe 'ラベルの検索機能' do
    it 'ラベルの検索ができる' do
      visit root_path
      select '事前登録済ラベル', from: 'label_search'
      click_on 'ラベル検索'
      expect(page).to have_content '事前登録済ラベル'
    end
    it '該当のラベルがない時、エラーメッセージが出る' do
      visit root_path
      select 'ラベル1', from: 'label_search'
      click_on 'ラベル検索'
      expect(page).to have_content '該当のラベルでの登録はありません'
    end
  end
end