require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成されたタスク一覧が表示される' do
      # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        visit new_task_path
        task = FactoryBot.create(:task)
        visit tasks_path(wait: 30)
        expect(page).to have_content 'Factoryで作ったコンテント1'
      # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面に
      # have_内容されているか（含まれているか）を確認（期待）するコードを書く
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'foo@example.com'
        fill_in '内容', with: '123456'
        click_on '登録する'
        visit new_task_path(wait: 30)
        fill_in 'タスク名', with: 'bar@example.com'
        fill_in '内容', with: '7890123'
        click_on '登録する'
        visit tasks_path
        task_list = all('task_row', wait: 30) #selenium関連のエラー回避のためwaitを追記
        expect(page).to have_content '7890123'
      end
      it '終了期限も登録されている' do
        travel_to Time.zone.local(2023, 9, 01) do
          visit new_task_path
          fill_in 'タスク名', with: 'wee@example.com'
          fill_in '内容', with: '7789'
          fill_in '終了期限', with: '2023,9,1'
          click_on '登録する'
          visit tasks_path(wait: 50)
          expect(page).to have_content '2023年09月01日'
        end
      end
    end
  end
end