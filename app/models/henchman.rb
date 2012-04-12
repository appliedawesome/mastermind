class Henchman
  include ActiveAttr::Model
  include ActiveAttr::TypecastedAttributes
  
  self.include_root_in_json = false
  
  attribute :action, :type => String
  attribute :name, :type => String
  
  validates_presence_of :name
  
  def self.allowed_actions
    @allowed_actions ||= [ 'nothing' ]
  end
  
  def self.from_hash(hash)
    henchman = find_by_name(hash["type"])
    result = henchman.new(hash)
    return result
  end
  
  def self.from_json(json)
    hash = Yajl.load(json)
    henchman = find_by_name(hash["type"])
    result = henchman.new(hash)
    return result
  end
  
  def self.find_by_name(name)
    Mastermind::Lair.henchmen[name]
  end
  
  def self.type(type=nil)
    @type = type.to_s if !type.nil?
    attribute :type, :type => String, :default => @type
    return @type
  end
  
  type :base
  
  def self.default_action(name=nil)
    @default_action = name.to_s if !name.nil?
    attribute :default_action, :type => String, :default => @default_action
    return @default_action
  end
  
  default_action :nothing
  
  def self.dsl_method(name, henchman, &block)
    new_henchman = henchman.new
    new_henchman.name name
    new_henchman.action (new_henchman.action || new_henchman.default_action)
    new_henchman.instance_eval(&block)
    tasks << new_henchman
  end
    
  def self.action(name, options={}, &block)
    name = name.to_s
    allowed_actions.push(name) unless allowed_actions.include?(name)
    
    define_method(name) do
      requires options[:requires] if options[:requires]
      Mastermind::Log.debug "Executing #{name} for #{to_s}."
      instance_eval(&block)
      self
    end
  end
  
  def initialize(attrs={})
    attrs.each_pair do |key, value|
      define_method key do |value|
        send("#{key}=", value)
      end
    end
    super(attrs)
  end
  
  def nothing
    Mastermind::Log.debug "Doing nothing."
    return true
  end
  
  def requires(*args)
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
    "#{type}[#{name}]"
  end

  def compile
    # We look for attributes that might be interpolating values from the plot's data or other resources. For example,
    # "{{data:server.hostname}}"
    attributes.each do |key, value|
      match = value.match(/{{(.*)}}/)
      # if match
        
        
        
    end
  end
  
  def execute
    action_to_execute = (self.action || self.default_action)
    unless self.class.allowed_actions.include?(action_to_execute)
      raise ArgumentError, "'#{action_to_execute}' is not a valid action."
    end
    
    if self.valid?
      begin
        self.send(action_to_execute)
        Mastermind::Log.debug "Action succeeded."
        self
      rescue => e
        Mastermind::Log.error "#{e.message}\n#{e.backtrace.join("\n")}"
        raise e.exception
      end
    else
      Mastermind::Log.error self.errors.full_messages.join(", ")
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
