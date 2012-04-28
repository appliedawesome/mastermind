class Goon
  include ActiveAttr::Model
  include ActiveAttr::TypecastedAttributes
  
  attribute :job, :type => Object
  attribute :heist, :type => Object
  
  # What to do before we execute a job
  def setup
  end
  
  # How we execute a job
  def execute
    job.execute
  end
  
  # What to do after we execute a job
  def report
    
  end

end

# job = Job.new(...)
# goon = Goon.new(job)
# goon.setup
# goon.execute
# goon.report