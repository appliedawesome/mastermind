class Heist # < ActiveRecord::Base
  include Mastermind::Helpers
  include ActiveAttr::Model

  attribute :data, :type => Hash, :default => {}
  
  # def initialize(attrs={})
  #   super(attrs)
  # end
  
  def data=(raw_data)
    flattened_data = to_dotted_hash(raw_data)
    write_attribute(:data, flattened_data)
  end
  
end
