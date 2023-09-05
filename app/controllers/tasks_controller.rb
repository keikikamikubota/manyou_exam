class TasksController < ApplicationController
  def index
    if params[:sort_expired]
      @tasks = Task.all.sort_expired
    else
      @tasks = Task.all.latest
    end
    if params[:name_search].present?
        @tasks = Task.n_search(params[:name_search]).latest
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクが登録できました"
    else
      render :new, notice: "登録に失敗しました"
    end

  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "更新が完了しました"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, flash: {success: "タスクが削除されました"}
  end

  private

  def task_params
      params.require(:task).permit(:name, :content, :expired_at, :sort_expired, :status)
  end
end