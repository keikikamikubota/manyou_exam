require 'rails_helper'
describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成されたタスクが表示される' do
      # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        visit new_task_path
      # 2. 新規登録内容を入力する
      #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        fill_in 'タスク名', with: 'foo@example.com'
        fill_in '内容', with: '123456'
      # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        click_on '登録する'
      # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        visit tasks_path
        expect(page).to have_content '123456'
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
        visit new_task_path
        fill_in 'タスク名', with: 'bar@example.com'
        fill_in '内容', with: '7890123'
        click_on '登録する'
        visit tasks_path
        task_list = all('task_row')
        expect(page).to have_content '7890123'
      end
      it '終了期限も登録されている'
      visit new_task_path
      fill_in 'タスク名', with: 'foo@example.com'
      fill_in '内容', with: '123456'
      fill_in '終了期限', with 'Date.current.tommorow'
      click_on '登録する'
      visit new_task_path
      fill_in 'タスク名', with: 'foo@example.com'
      fill_in '内容', with: '7789'
      fill_in '終了期限', with 'Date.current.tommorow'
      visit tasks_path
      task_list = all('task_expired_at')
      expect(page).to 
    end
  end
end