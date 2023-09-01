require 'rails_helper'
describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成されたタスクが表示される' do
      # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        visit new_task_path
      # 2. 新規登録内容を入力する
      #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        fill_in 'Name', with: 'foo@example.com'
        fill_in 'Content', with: '123456'
      # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        click_on '登録する'
      # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        visit tasks_path
        expect(page).to have_content '123456'
      # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面に
      # have_contentされているか（含まれているか）を確認（期待）するコードを書く
      end
    end
  end
end