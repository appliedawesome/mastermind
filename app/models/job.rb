class Job < ActiveRecord::Base
  
  include ActiveAttr::Model
  include ActiveAttr::TypecastedAttributes

  attribute :target, :type => Object # Target
  attribute :action, :type => String
  
  def execute
    target.send(action)
  end
end


# job = Job.new(:target => @target)
