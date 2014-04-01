class Task < ActiveRecord::Base
  belongs_to :project
  validates :tasktype, presence:true
  validate :end_after_start

  private
  def end_after_start
    if end_date < start_date
      log = File.open("log.txt", 'w')
      log.puts(end_date)
      log.close()
      errors.add(:end_date, "must be after the start date")
    end
  end

end
