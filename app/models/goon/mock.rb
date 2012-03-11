class Goon::Mock < Goon
  default_action :run
  
  attribute :message, :type => String
  
  validates_presence_of :message
  
  action :pass, :requires => [:message, :name] do
    puts message
    true
  end
  
  action :fail, :requires => :message do
    raise StandardError
  end
end