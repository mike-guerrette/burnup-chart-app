class Project < ActiveRecord::Base
  has_many :tasks
  has_many :scope_changes
  has_one :scope
  validates :name, presence:true
  #validates_format_of :name, :without => /^\d/

  def self.find(input)
    if input.is_a?(Integer)
      super
    else
      find_by_name(input)
    end
  end

  def to_param
    name
  end

end
