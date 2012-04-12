module Mastermind
  class Lair
    @henchmen = Hash.new.with_indifferent_access

    class << self
      attr_accessor :henchmen
    end

  end
end