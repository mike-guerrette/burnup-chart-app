class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @project = Project.find(params[:project_id])
    numShow = params[:show]
    numShow.nil? ? num = 10 : num = numShow
    @tasks = @project.tasks.order('updated_at DESC').limit(num)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  def import

    @project = Project.find(params[:project_id])

    @data = Task.import(params[:file])

    unless @data == -1
      @data.each do |task|
        #@project.tasks.create(task[:task_type],task[:start_date], task[:end_date], task[:days_on_hold], task[:reason_on_hold])
        @project.tasks.create! task
      end
      redirect_to project_tasks_path, alert: "Spreadsheet imported."
    else
      render 'tasks/error'
    end

  end

  # GET /tasks/new
  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.create(params[:task].permit(:tasktype, :start_date, :end_date, :days_on_hold, :reason_on_hold))
    redirect_to project_path(@project)


=begin
    respond_to do |format|
      if @task.save
        format.html { redirect_to @project, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
=end


  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_tasks_path, notice: 'Task was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @task }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    #@project = Project.find(params[:project_id])
    #@task = @project.tasks.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path }
      format.json { head :no_content }
    end
  end

  def delete_all
    @project = Project.find(params[:project_id])
    @project.tasks.each do |task|
      task.destroy
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:tasktype, :start_date, :end_date, :days_on_hold, :reason_on_hold)
  end
end
