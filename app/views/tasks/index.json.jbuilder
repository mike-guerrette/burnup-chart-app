json.array!(@tasks) do |task|
  json.extract! task, :id, :tasktype, :start_date, :end_date, :days_on_hold, :reason_on_hold
  json.url task_url(task, format: :json)
end
