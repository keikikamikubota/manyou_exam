require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # describe '一覧表示機能' do
  #   context '一覧画面に遷移した場合' do
  #     it '作成されたタスク一覧が表示される' do
  #       visit new_task_path
  #       task = FactoryBot.create(:task)
  #       visit tasks_path(wait: 30)
  #       expect(page).to have_content 'コンテント1'
  #     end
  #   end
  #   context 'タスクが作成日時の降順に並んでいる場合' do
  #     it '新しいタスクが一番上に表示される' do
  #       visit new_task_path
  #       task = FactoryBot.create(:task)
  #       sleep 5
  #       visit new_task_path
  #       task = FactoryBot.create(:second_task)
  #       visit tasks_path
  #       task_list = all('task_row')
  #       expect(page).to have_content 'コンテント2'
  #     end
  #     it '終了期限も登録されている' do
  #       travel_to Time.zone.local(2023, 9, 01) do
  #         visit new_task_path
  #         task = FactoryBot.create(:third_task)
  #         visit tasks_path
  #         sleep 5 #selenium関連のエラー回避のためsleepを追記
  #         expect(page).to have_content '2023年09月03日'
  #       end
  #     end
  #   end
  # end
  describe 'タスクのステータス機能' do
    # context 'タスクを新規登録するとき' do
    #   it 'ステータスも登録ができる' do
    #     visit new_task_path
    #     task = FactoryBot.create(:task)
    #     visit tasks_path
    #     sleep 5
    #     expect(page).to have_content '未着手'
    #   end
    # end
    context '終了期限でソートをするとき' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        travel_to Time.zone.local(2023, 9, 01) do
          task = FactoryBot.create(:task)
          task = FactoryBot.create(:second_task)
          task = FactoryBot.create(:third_task)
          visit tasks_path
          click_on '終了期限'
          sleep 5
          task_list = all('.task_names')
          expect(task_list[0]).to have_content 'タイトル2'
        end
      end
    end
  end
end