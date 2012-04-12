module Mastermind::Config
  extend self
  
  def setup
    yield self
    self
  end
  
  def henchman(type, henchman_class)
    Mastermind::Lair.henchmen[type] = henchman_class
    henchman_class.type type
  end
end
