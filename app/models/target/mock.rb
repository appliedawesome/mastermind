class Target::Mock < Target  
  attribute :message, :type => String
  
  validates_presence_of :message
  
  action :pass, :needs => :message do
    puts message
    true
  end
  
  action :fail, :needs => :message do
    raise StandardError
  end
end