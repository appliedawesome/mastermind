module Mastermind::Config
  extend self
  
  def setup
    yield self
    self
  end
  
  def goon(type, goon_class)
    Mastermind::Lineup.goons[type] = goon_class
    goon_class.type type
  end
end
