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
          errors.add(:base, "#{attribute} #{message}")
        end
      end
      # errors.messages.each do |attribute, messages|
      #         messages.map! { |message| "Job #{name}: #{message}" }
      #         heist.errors.add(:base, messages)
      #       end
      teardown
      return false
    end
  end
  
  
  def compile_profile
    # We look for attributes that might be interpolating values from the heist's profile or other resources. For example,
    # "{{data:server.hostname}}"
    
    # Return right away if there's no profile
    return if profile.empty?
    
    profile.each do |key, value|
      next if value.nil?
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
  
  private
  
  def setup
    compile_profile
    Rails.logger.debug "Setting up job", :attributes => attributes
    Rails.logger.debug "Setting up target", :profile => profile
    @target = Mastermind::HitList.targets[target_name].new(profile)
  end

  def teardown
    Rails.logger.debug "Tearing down job", :attributes => attributes
    @target = nil    
  end
  
end
