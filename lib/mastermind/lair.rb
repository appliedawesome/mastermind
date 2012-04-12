module Mastermind
  class Lineup
    @goons = Hash.new.with_indifferent_access

    class << self
      attr_accessor :goons
    end

  end
end