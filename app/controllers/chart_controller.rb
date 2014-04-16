require 'business_time'

class ChartController < ApplicationController

  def generateWeeks
    weeks = []
    (1..7).each do |i|
      weeks.unshift (Date.today.end_of_week - i*7)
    end
    weeks
  end

  def generateMonths
    weeks = []
    (1..24).each do |i|
      weeks.unshift (Date.today.end_of_week - i*7)
    end
    logger.info weeks
    weeks
  end

  def generateData
    @data_arr = []

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
      @data_arr.append(tempHash)
    end
      @data_arr
  end

  def getWeeklyData(tasktype, time_period)
    temp = []
    time_period.each do |week|
      numTasks = @tasks.where(tasktype: tasktype)
                        .where("end_date < ?", week)
                        .where("end_date > ?", week - 7)
                        .length
      temp << numTasks
    end
    temp
  end

  def getCumulativeTasks (time_period)
    temp = []
    time_period.each do |week|
      temp << @tasks.where("end_date < ?", week).length
    end
    temp
  end

  def generateSeries (time_period)
    series = []

    #Adding task type totals to stacked bar chart
    @tasktypes.each do |ttype|
      temp = Hash.new
      temp[:name] = ttype
      temp[:type] = 'column'
      temp[:data] = getWeeklyData(ttype, time_period)
      series << temp
    end

    #Adding data for cumulative task line
    cline = Hash.new
    cline[:name] = 'Cumulative'
    cline[:type] = 'spline'
    cline[:yAxis] = 1
    cline[:data] = getCumulativeTasks (time_period)
    cline[:dashStyle] = 'shortdot'
    series << cline

    #Adding items to have them show on the legend, this will actually have to change.
    scope = Hash.new
    scope[:name] = 'Scope'
    scope[:type] = 'line'
    scope[:dashStyle] = 'longdash'
    scope[:color] = '#000'
    series << scope

    release = Hash.new
    release[:name] = 'Projected Release Date'
    release[:type] = 'line'
    release[:color] = '#F00'
    series << release

    return series

  end

  def generatePieData
    data = []
    @tasktypes.each do |ttype|
      data << [ttype, @tasks.where(tasktype: ttype).length]
    end
    data
  end

  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
    @tasktypes = @tasks.pluck('DISTINCT tasktype').sort

    @scopes = @project.scope_changes.pluck(:scope)
    @scope = 0
    for i in @scopes
      @scope = @scope + i
    end
    logger.info @scope

    @data = generateData
    @weeks = generateWeeks
    @series1 = generateSeries (@weeks)

    @months = generateMonths
    @series2 = generateSeries (@months)
    @pie_data = generatePieData

    #numScope = params[:scope]
    #numScope.nil? ? @scope = 125 : @scope = numScope
  end
end
