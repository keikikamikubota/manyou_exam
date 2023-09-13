require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    user = FactoryBot.create(:user)
    user = FactoryBot.create(:second_user)
    user = FactoryBot.create(:third_user)
  end

  describe 'ユーザー登録のテスト' do
    context 'ユーザーを新規登録した場合' do
      it 'タスク一覧画面にログインユーザーの名前が見れる' do
        visit new_user_path
        fill_in 'user_name', with: '一般ユーザー4' #fill_inの中は検証ツールのidを参照
        fill_in 'user_email', with: 'ippan4@example.com'
        fill_in 'user_password', with: 'ippan4'
        fill_in 'user_password_confirmation', with: 'ippan4'
        click_on '新規登録'
        sleep 5
        expect(page).to have_content '一般ユーザー4'
      end
    end
    context 'ログインしていない場合' do
      it 'タスク一覧に飛ぼうとしてもログイン画面に遷移される' do
      visit tasks_path
      expect(page).to have_content 'Log in'
      end
    end
  end

  describe 'セッション機能のテスト' do
    let(:user_a){ FactoryBot.create(:user, name: '別ユーザー',
                  email: 'other@example.com', password: 'other') }
    before do
      visit root_path
      fill_in 'session_email', with: 'ippan2@example.com'
      fill_in 'session_password', with: 'ippan2'
      click_on 'Log in'
    end
    context 'ログインした際' do
      it "ログインが成功している" do
        visit root_path
        sleep 5
        expect(page).to have_content 'タスク一覧'
      end
      it "自分の詳細画面（マイページ）に飛べる" do
        click_on '一般ユーザー2'
        expect(page).to have_content '一般ユーザー2のページ'
      end
      it '一般ユーザが他人の詳細画面に飛ぶと、タスク一覧画面に遷移する' do
        visit user_path(user_a.id) #letを使ってidを引き渡し、そこにリンクさせる
        expect(current_path).to eq tasks_path
      end
      it 'ログアウトができる' do
        click_on 'ログアウト'
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '管理画面のテスト' do
    let(:user) { FactoryBot.create(:user) }
    let(:user_a){ FactoryBot.create(:user, name: '別ユーザー',
                                          email: 'other@example.com',
                                           password: 'other') }
    before do
      visit root_path
      fill_in 'session_email', with: 'admin1@example.com'
      fill_in 'session_password', with: 'admin1'
      click_on 'Log in'
      sleep 1
    end
    context '管理ユーザーとしてログインした時' do
      it '管理ユーザーは管理画面でアクセスできている' do
        expect(page).to have_content '管理者用'
      end
      it '一般ユーザーは管理画面にアクセスはできない' do
        visit root_path
        click_on 'ログアウト'
        sleep 1
        fill_in 'session_email', with: 'ippan2@example.com'
        fill_in 'session_password', with: 'ippan2'
        click_on 'Log in'
        sleep 1
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        visit admin_user_path(user_a)
        expect(current_path).to eq admin_user_path(user_a)
      end
      it '管理ユーザーはユーザーの編集画面からユーザーを編集できる' do
        visit admin_user_path(user_a)
        click_on '編集'
        fill_in 'user_name', with: '編集後'
        fill_in 'user_password', with: 'henshu'
        fill_in 'user_password_confirmation', with: 'henshu'
        click_on 'ユーザー登録'
        expect(page).to have_content '編集後'
      end
      it 'ユーザーの削除ができる' do
        visit admin_user_path(user_a.id)
        click_on '削除'
        sleep 1
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content '別ユーザーを削除しました'
      end
    end
  end
end