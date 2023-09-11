class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    if current_user.id
      flash[:alert] = "すでにユーザー登録済みです"
      redirect_to tasks_path
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:alert] =  "本人以外のユーザー閲覧はできません"
      redirect_to tasks_path
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(@user.id), notice: "本人以外はユーザー編集ができません"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "登録が完了しました。"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
