class Heist < ActiveRecord::Base
  has_many :jobs
  accepts_nested_attributes_for :jobs
  
  serialize :profile, JSON
  
  validates :name, :uniqueness => true, :presence => true
  
  def pre
    
  end
  
  def execute
    
  end
  
  def post
    
  end
end
