module Mastermind
  module Helpers
    def to_dotted_hash(source, target = {}, namespace = nil)
      prefix = "#{namespace}." if namespace
      case source
      when Hash
        source.each do |key, value|
          to_dotted_hash(value, target, "#{prefix}#{key}")
        end
      when Array
        source.each_with_index do |value, index|
          to_dotted_hash(value, target, "#{prefix}#{index}")
        end
      else
        target[namespace] = source
      end
      target
    end
  end
end