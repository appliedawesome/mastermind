class Target
  include ActiveAttr::Model
  include ActiveAttr::TypecastedAttributes
  
  self.include_root_in_json = false

  attribute :options, type: Object, default: {}
  # attribute :required_attributes, type: Object, default: {}
  
  def self.required_attributes
    @required_attributes ||= {}
  end
  
  def required_attributes
    self.class.required_attributes
  end
  
  def self.type(type=nil)
    @type = type.to_s if !type.nil?
    attribute :type, type: String, default: @type
    return @type
  end
  
  def self.allowed_actions
    @allowed_actions ||= [ :nothing ]
  end
    
  def self.action(action_name, options={}, &block)
    action_name = action_name.to_sym
    allowed_actions.push(action_name) unless allowed_actions.include?(action_name)
    required_attributes[action_name] = [ options[:requires] ].flatten
    
    define_method(action_name) do
      requires required_attributes[action_name]
      # Rails.logger.debug "Executing #{action_name} for #{to_s}."
      instance_eval(&block)
      # self
    end
  end
  
  def self.required_attributes_for(action)
    required_attributes[action]
  end
  
  def nothing
    Rails.logger.debug "Doing nothing."
    return true
  end
  
  def requires(*args)
    args.flatten!
    
    args.each do |arg|
      unless attributes[arg] || self.send(arg)
        errors.add(arg, "can't be blank") 
      end
    end
  end

  def to_s
    "target[#{type}]"
  end
    
  def execute(action_to_execute)
    # clear out any previously encountered errors
    errors.clear
    
    action_to_execute = action_to_execute.to_sym
    
    unless self.class.allowed_actions.include?(action_to_execute)
      errors.add(:action, "is not valid")
    end
    
    begin
      self.send(action_to_execute)
    rescue => e
      Rails.logger.error e.message, :backtrace => e.backtrace
      errors.add(:exception, e.message)
      return false
    end
    
    if self.errors.empty?
      return self
    else
      return false
    end
  end
  
  # Fake the save! method so FactoryGirl won't poop itself
  def save!
    true
  end
  
end
