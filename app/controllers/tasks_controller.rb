class TasksController < ApplicationController
  def index
    @tasks = Task.all
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

  end

  def destroy

  end

  private

  def task_params
      params.require(:task).permit(:name, :content)
  end
end
