class TaskTimeTableController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
    @tasktypes = @tasks.pluck('DISTINCT tasktype')
    @data = []
    #@tasktypes.each do |ttype|
    # tasks = @tasks.where("tasktype = #{ttype}")
    #  tasks.each do |task|
    #    @data.append(task.tasktype)
    #  end
    #end

  end
end
