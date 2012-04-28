class Job < ActiveRecord::Base
  belongs_to :heist
  
  validates :name, :uniqueness => { :scope => :heist_id }, :presence => true
  validates :target_name, :presence => true
  validates :action, :presence => true  
  
  serialize :profile, JSON
  
  attr_accessor :target
  attr_accessor :state
  
  def execute
    @state = 'pending'
    begin
      setup
      @target.execute(action)
      @state = 'success'
    rescue => e
      # Rails.logger.info e.message, :backtrace => e.backtrace
      @state = 'failure'
    ensure
      teardown
    end
  end
  
  def setup
    Rails.logger.info "Setting up job", :attributes => attributes
    Rails.logger.info "Setting up target", :profile => profile
    @target = HitList.targets[target_name].new(profile)
  end

  def teardown
    Rails.logger.info "Tearing down job", :attributes => attributes
    @target = nil    
  end
  
end
