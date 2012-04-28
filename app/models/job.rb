class Job < ActiveRecord::Base
  belongs_to :heist
  
  validates :name, :uniqueness => { :scope => :heist_id }, :presence => true
  validates :target_name, :presence => true
  validates :action, :presence => true  
  
  serialize :profile, JSON
  
  attr_accessor :target, :success

  def execute
    setup
    if @target.execute(action)
      teardown
      return self
    else
      @target.errors.messages.each do |attribute, messages|
        messages.each do |message|
          errors.add(attribute, message)
        end
      end
      teardown
      return false
    end
  end
  
  
  def compile_profile
    # We look for attributes that might be interpolating values from the heist's profile or other resources. For example,
    # "{{data:server.hostname}}"
    profile.each do |key, value|
      match = value.match(/{{(.*)}}/)
      if match
        if match.captures.length > 1
          errors.add(:base, "Too many keys matched.")
          return false
        end
      
        to_replace = heist.profile[match[1]]
        if to_replace
          profile[key] = to_replace
        else
          errors.add(:base, "Could not find #{key} in heist profile with match {{#{match[1]}}}")
          return false
        end
      end
    end
  end
  
  def setup
    compile_profile
    # Rails.logger.info "Setting up job", :attributes => attributes
    # Rails.logger.info "Setting up target", :profile => profile
    @target = HitList.targets[target_name].new(profile)
  end

  def teardown
    # Rails.logger.info "Tearing down job", :attributes => attributes
    @target = nil    
  end
  
  def report
    { :success => @success }
  end
  
end
