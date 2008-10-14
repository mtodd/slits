module Merb
  module GlobalHelpers
    
    def pluralize(word, number)
      if number > 1 or number == 0
        word.pluralize % [number]
      else
        word.singularize % [number]
      end
    end
    
  end
end
