class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required, only: [:new, :create, :show, :index,]

  private

  def login_required
    redirect_to new_session_path unless current_user
  end

  def if_not_admin
    if current_user.admin == false
      flash[:danger] = "管理者ユーザーでログインしてください"
      redirect_to tasks_path
    end
  end
end