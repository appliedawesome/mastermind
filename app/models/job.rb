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
  
  def setup
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
