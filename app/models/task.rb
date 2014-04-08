
class Task < ActiveRecord::Base

  belongs_to :project
  validates :tasktype, presence:true
  validate :end_after_start

  private
  def end_after_start
    if end_date < start_date
      errors.add(:end_date, "must be after the start date.")
    end
  end

  def self.import(file)

    logger.info "Beginning import process"

    #File.rename(file.path, file.path + File.extname(file.original_filename))

    workbook = Roo::Excelx.new(file.path, nil, :ignore)
    data_array = Array.new

    row = 7

    while true

      tempHash = Hash.new
      start_date = workbook.cell(row, 5, workbook.sheets[1])
      break if start_date.nil?

      tempHash[:start_date] = start_date

      end_date = workbook.cell(row, 8, workbook.sheets[1])

      if (end_date < start_date)
        #errors.add(:end_date, "End date is before start date in row " + row.to_s)
        return -1
      end

      tempHash[:end_date] = end_date

      task_type = workbook.cell(row, 10, workbook.sheets[1])
      tempHash[:tasktype] = task_type

      days_on_hold = workbook.cell(row, 12, workbook.sheets[1])
      tempHash[:days_on_hold] = days_on_hold || 0

      reason_on_hold = workbook.cell(row, 13, workbook.sheets[1])
      tempHash[:reason_on_hold] = reason_on_hold

      row += 1
      data_array << (tempHash)
    end

    return data_array, row


  end
end

