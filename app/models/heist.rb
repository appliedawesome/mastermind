class Heist # < ActiveRecord::Base
  include Mastermind::Helpers
  include ActiveAttr::Model

  
  attribute :heist_data, :type => Hash, :default => {}
  attribute :jobs_data, :type => Array, :default => []
  attribute :pending_jobs, :type => Array, :default => []
  attribute :running_jobs, :type => Array, :default => []
  attribute :completed_jobs, :type => Array, :default => []
  
  
  def data=(raw_data)
    flattened_data = to_dotted_hash(raw_data)
    write_attribute(:data, flattened_data)
  end
  
  def pre
    
  end
  
  def execute
    
  end
  
  def post
    
  end
  
  def create_jobs
    jobs.map! do |job|
      if job.is_a?(Job)
        next
      else
        Job.new(:target => Target.from_hash(job)) 
      end
    end
  end
  
end
