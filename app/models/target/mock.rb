class Target::Mock < Target  
  attribute :message, :type => String
    
  action :pass do
    requires :message
    
    puts message
    true
  end
  
  action :fail do
    requires :message
    
    raise StandardError, "A failing action!"
  end
end