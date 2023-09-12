class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :if_not_admin

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "登録が完了しました。"
      redirect_to admin_user_path(@user.id)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: "ユーザー#{@user.name}を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー#{@user.name}を削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password,
                                 :password_confirmation)
  end
end
