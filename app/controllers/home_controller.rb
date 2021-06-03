class HomeController < ApplicationController
  def index
    @tasks = Task.all
    @categories = Category.all
  end

  def new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    @category = Category.find(category_params)
    @task.category = @category

    if @task.save
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js { }
        flash[:notice] = "Task created"
      end
    else
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js { }
        flash[:notice] = "Please try again"
      end
    end
  end
end
