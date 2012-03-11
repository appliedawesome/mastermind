module Mastermind::Config
  extend self
  
  def setup
    yield self
    self
  end
  
  def goon(goon_name, goon_class)
    Mastermind::Lineup.goons[goon_name] = goon_class
    goon_class.goon_name goon_name
  end
end
