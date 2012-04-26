module Mastermind
  class HitList
    @targets = Hash.new.with_indifferent_access

    class << self
      attr_accessor :targets
    end

  end
end