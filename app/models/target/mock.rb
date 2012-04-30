class Target::Mock < Target  
  attribute :message, type: String
    
  action :pass, :requires => :message do
    puts message
    true
  end
  
  action :fail, :requires => :message do
    raise StandardError, "A failing action!"
  end
end