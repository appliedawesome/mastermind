class Goon
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
    goon = find_by_name(hash["goon_name"])
    result = goon.new(hash)
    return result
  end
  
  def self.from_json(json)
    hash = Yajl.load(json)
    goon = find_by_name(hash["goon_name"])
    result = goon.new(hash)
    return result
  end
  
  def self.find_by_name(name)
    Mastermind::Lineup.goons[name]
  end
  
  def self.goon_name(goon_name=nil)
    @goon_name = goon_name.to_s if !goon_name.nil?
    attribute :goon_name, :type => String, :default => @goon_name
    return @goon_name
  end
  
  goon_name :base
  
  def self.default_action(name=nil)
    @default_action = name.to_s if !name.nil?
    attribute :default_action, :type => String, :default => @default_action
    return @default_action
  end
  
  default_action :nothing
  
  def self.dsl_method(name, goon, &block)
    new_goon = goon.new
    new_goon.name name
    new_goon.action (new_goon.action || new_goon.default_action)
    new_goon.instance_eval(&block)
    tasks << new_goon
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
    "#{goon_name}[#{name}]"
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
end
