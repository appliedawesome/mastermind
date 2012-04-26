class Target::Mock < Target
  # default_action :pass
  
  attribute :message, :type => String
  
  validates_presence_of :message
  
  action :pass, :needs => [:message, :name] do
    puts message
    true
  end
  
  action :fail, :needs => :message do
    raise StandardError
  end
end