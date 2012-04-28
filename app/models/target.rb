class Target
  include ActiveAttr::Model
  include ActiveAttr::TypecastedAttributes
  
  self.include_root_in_json = false

  def self.allowed_actions
    @allowed_actions ||= [ :nothing ]
  end
  
  def self.from_hash(hash)
    target = find_by_type(hash["type"] || hash[:type])
    result = target.new(hash)
    return result
  end
  
  def self.from_json(json)
    hash = Yajl.load(json)
    target = find_by_type(hash["type"])
    result = target.new(hash)
    return result
  end
  
  def self.find_by_type(type)
    Mastermind::HitList.targets[type]
  end
  
  def self.type(type=nil)
    @type = type.to_s if !type.nil?
    attribute :type, :type => String, :default => @type
    return @type
  end
  
  def self.dsl_method(name, target, &block)
    new_target = target.new
    new_target.name name
    new_target.action (new_target.action || new_target.default_action)
    new_target.instance_eval(&block)
    tasks << new_target
  end
    
  def self.action(action_name, options={}, &block)
    action_name = action_name.to_sym
    allowed_actions.push(action_name) unless allowed_actions.include?(action_name)
        
    define_method(action_name) do
      # Rails.logger.debug "Executing #{action_name} for #{to_s}."
      instance_eval(&block)
      self
    end
  end
  
  def nothing
    Rails.logger.debug "Doing nothing."
    return true
  end
  
  def requires(*args)
    args = args.flatten
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
    action_to_execute = action_to_execute.to_sym
    
    unless self.class.allowed_actions.include?(action_to_execute)
      errors.add(:action, "is not valid")
    end
    
    begin
      self.send(action_to_execute)
    rescue => e
      errors.add(:exception, e.message)
      return false
    end
    
    if self.errors.empty?
      return self
    else
      return false
    end
  end
  
  # Fake the save process so FactoryGirl won't poop itself
  def save!
    true
  end
  
  
end
