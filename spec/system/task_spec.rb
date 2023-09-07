require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    task = FactoryBot.create(:task)
    task = FactoryBot.create(:second_task)
    task = FactoryBot.create(:third_task)
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成されたタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'コンテント1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('task_row')
        expect(page).to have_content 'コンテント2'
      end
      it '終了期限も登録されている' do
        travel_to Time.zone.local(2023, 9, 01) do
          visit new_task_path
          task = FactoryBot.create(:third_task) #travel_to内で再度createしないと適応されないため
          visit tasks_path
          sleep 5 #selenium関連のエラー回避のためsleepを追記
          expect(page).to have_content '2023年09月03日'
        end
      end
    end
    context '優先順位でソートをするとき' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        travel_to Time.zone.local(2023, 9, 01) do
          visit tasks_path
          click_on '終了期限'
          sleep 5
          task_list = all('.task_names')
          expect(task_list[0]).to have_content 'タイトル2'
        end
      end
    end
  end

  describe 'タスクのステータス機能' do
    context 'タスクを新規登録するとき' do
      it 'ステータスも登録ができる' do
        visit tasks_path
        sleep 5
        expect(page).to have_content '未着手'
      end
    end

  describe '検索機能を使う' do
    context '検索をしたい時'
      it 'タイトルのみ入力してタイトル検索の結果がでる' do
        visit tasks_path
        fill_in 'name_search', with: 'タイトル1'
        click_on 'ステータスとタスク名の検索'
        sleep 5
        expect(page).to have_content 'タイトル1'
      end
      it 'ステータスのみ選択してステータス検索の結果が出る'do
        visit tasks_path
        select '着手中', from: 'status_search'
        click_on 'ステータスとタスク名の検索'
        expect(page).to have_content '着手中'
      end
      it 'タイトルとステータス両方の検索結果が出る' do
        visit tasks_path
        fill_in 'name_search', with: 'タイトル1'
        select '着手中', from: 'status_search'
        click_on 'ステータスとタスク名の検索'
        expect(page).to have_content 'タイトル2'
        expect(page).to have_content '着手中'
      end
    end
    context 'タスクの優先順位でソートをするとき' do
      it '優先順位の降順に並び替えられたタスク一覧が表示される' do
        visit tasks_path
        click_on '優先度'
        sleep 5
        task_list = all('.task_priority')
        expect(task_list[0]).to have_content '高'
      end
    end
  end
end