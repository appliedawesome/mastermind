class Target
  include ActiveAttr::Model
  include ActiveAttr::TypecastedAttributes
  
  self.include_root_in_json = false
  
  # attribute :action, :type => String
  # attribute :name, :type => String
  # attribute :state, :type => String, :default => 'pending'
  # validates_presence_of :name
  
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
  
  # type :base
  
  # def self.default_action(name=nil)
  #   @default_action = name.to_s if !name.nil?
  #   attribute :default_action, :type => String, :default => @default_action
  #   return @default_action
  # end
  # 
  # default_action :nothing
  
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
      needs options[:needs] if options[:needs]
      Rails.logger.debug "Executing #{action_name} for #{to_s}."
      instance_eval(&block)
      self
    end
  end
  
  # def initialize(attrs={})
  #   attrs.each_pair do |key, value|
  #     define_method key do |value|
  #       send("#{key}=", value)
  #     end
  #   end
  #   super(attrs)
  # end
  
  def nothing
    Rails.logger.debug "Doing nothing."
    return true
  end
  
  def needs(*args)
    missing = []
    args.flatten.each do |arg|
      unless self.send("#{arg}") || self.attributes.has_key?(arg)
        missing << arg
      end
    end
    if missing.length == 1
      raise ArgumentError, "#{missing.first} is required for this operation."
    elsif missing.any?
      raise ArgumentError, "#{missing[0...-1].join(", ")} and #{missing[-1]} are required for this operation."
    end
  end

  def to_s
    "target[#{type}]"
  end

  def compile
    # We look for attributes that might be interpolating values from the heist's data or other resources. For example,
    # "{{data:server.hostname}}"
    attributes.each do |key, value|
      match = value.match(/{{(.*)}}/)
      # if match
    end
  end
  
  def execute(action_to_execute)
    action_to_execute = action_to_execute.to_sym
    unless self.class.allowed_actions.include?(action_to_execute)
      raise ArgumentError, "'#{action_to_execute}' is not a valid action."
    end
        
    if self.valid?
      begin
        self.send(action_to_execute)
        Rails.logger.debug "Action succeeded."
        self
      rescue => e
        Rails.logger.error e.message, :backtrace => e.backtrace
        raise e.exception
      end
    else
      Rails.logger.error self.errors.full_messages.join(", ")
      raise ArgumentError, self.errors.full_messages.join(", ")
    end
  end
  
  def report
  end
  
  # Fake the save process so FactoryGirl won't poop itself
  def save!
    true
  end
  
  
end
