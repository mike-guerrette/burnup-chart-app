class TaskTimeTableController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
    @tasktypes = @tasks.pluck('DISTINCT tasktype')
    @data = []
    #@data.append(@tasks.group(:tasktype).count)

    @tasktypes.each do |ttype|
      tempHash = Hash.new()
      tempHash[:task_type] = ttype
      tasks = @tasks.where(tasktype: ttype)
      tempHash[:num_tasks] = tasks.length

      totalDays = 0
      tasks.each do |task|
        if task.days_on_hold.nil?
          days = (task.end_date - task.start_date).to_i
        else
          days = (task.end_date - task.start_date).to_i - task.days_on_hold
        end
        totalDays += days
      end
      tempHash[:num_days] = totalDays
      @data.append(tempHash)

    end


  end
end
