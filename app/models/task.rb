class Task < ActiveRecord::Base
  belongs_to :project
  validates :tasktype, presence:true
end
