class Heist < ActiveRecord::Base
  has_many :jobs
  accepts_nested_attributes_for :jobs
  
  serialize :profile, JSON
  
  validates :name, :uniqueness => true, :presence => true
  
  attr_accessor :pending_jobs, :completed_jobs
  
  def pre
    
  end
  
  def start
    
  end
  
  def post
    
  end
  
end
