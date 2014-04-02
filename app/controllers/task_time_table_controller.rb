class TaskTimeTableController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
    @tasktypes = @tasks.pluck('DISTINCT tasktype')
    data = []
    @tasktypes.each do |ttype|
      tasks = @tasks.where('tasktype == #{ttype}')
    end

  end
end
