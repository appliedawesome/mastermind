class Goon
  include ActiveAttr::Model
  include ActiveAttr::TypecastedAttributes
  
  attribute :job, :type => Object
  attribute :heist, :type => Object
  
  # What to do before we execute a job
  def setup
    Rails.logger.debug "Setting up goon"
  end
  
  # How we execute a job
  def execute
    if job.execute
      return true
    else
      return false
    end
  end
  
  def teardown
    Rails.logger.debug "Tearing down goon"
  end
  
  # What to do after we execute a job
  def report
    
  end

  # Fake the save! method so FactoryGirl won't poop itself
  def save!
    true
  end
  
end

# job = Job.new(...)
# goon = Goon.new(job)
# goon.setup
# goon.execute
# goon.report