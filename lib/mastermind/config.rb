module Mastermind::Config
  extend self
  
  def setup
    yield self
    self
  end
  
  def target(type, target_class)
    Mastermind::HitList.targets[type] = target_class
    target_class.type type
  end
end
