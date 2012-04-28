class Job < ActiveRecord::Base
  belongs_to :heist
  
  validates :name, :uniqueness => { :scope => :heist_id }, :presence => true
  validates :target, :presence => true
  validates :action, :presence => true
end
