require 'roo'

workbook = Roo::Excelx.new("Dev Metrics-InternalTools.xlsx")
data_array = Array.new

=begin
start_date =  workbook.column(5, workbook.sheets[1]).drop(6).compact
end_date = workbook.column(8, workbook.sheets[1]).drop(6).compact
task_type = workbook.column(10, workbook.sheets[1]).drop(6).compact
days_on_hold = workbook.column(12, workbook.sheets[1]).drop(6).compact
reason_on_hold = workbook.column(13, workbook.sheets[1]).drop(6).compact

puts start_date
=end

row = 7

while true
  tempHash = Hash.new
  start_date = workbook.cell(row, 5, workbook.sheets[1])
  break if start_date.nil?
  tempHash[:start_date] = start_date

  end_date = workbook.cell(row, 8, workbook.sheets[1])
  tempHash[:end_date] = end_date

  task_type = workbook.cell(row, 10, workbook.sheets[1])
  tempHash[:task_type] = task_type

  days_on_hold = workbook.cell(row, 12, workbook.sheets[1])
  tempHash[:days_on_hold] = days_on_hold

  reason_on_hold = workbook.cell(row, 13, workbook.sheets[1])
  tempHash[:reason_on_hold] = reason_on_hold

  row += 1
  data_array << (tempHash)
end

puts data_array