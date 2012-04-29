class Heist < ActiveRecord::Base
  has_many :jobs
  accepts_nested_attributes_for :jobs
  
  serialize :profile, JSON
  
  validates :name, :uniqueness => true, :presence => true
  
  attr_accessor :pending_jobs, :completed_jobs
  
  def setup
    @pending_jobs = []
    @completed_jobs = []
    
    jobs.each do |job|
      pending_jobs << job
    end
  end
  
  def execute
    setup
    # while pending_jobs.pop do 
    jobs.each do |job|
    end
    teardown
  end
  
  def teardown
    
  end
  
end
