require 'business_time'

class TaskTimeTableController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
    @tasktypes = @tasks.pluck('DISTINCT tasktype')
    @data = []

    @tasktypes.each do |ttype|
      tempHash = Hash.new()
      tempHash[:task_type] = ttype
      tasks = @tasks.where(tasktype: ttype)
      tempHash[:num_tasks] = tasks.length

      totalDays = 0
      daysOnHold = 0
      tasks.each do |task|
        if task.days_on_hold.nil?
          #Need to make sure this is getting the correct number of days when compared to Excel.
          days = task.start_date.business_days_until(task.end_date)
        else
          #days = (task.end_date - task.start_date).to_i - task.days_on_hold
          daysOnHold += task.days_on_hold
          days = task.start_date.business_days_until(task.end_date) - task.days_on_hold
        end
        totalDays += days
      end
      tempHash[:num_days] = totalDays
      tempHash[:days_on_hold] = daysOnHold
      @data.append(tempHash)

    end



  end
end
