module Broken
  module Mirror
    module Foldable
      # foldl :: (a -> b) -> xs -> b
      def self.foldl
        proc do |block, *rest|
          if rest.size == 1 && rest.first.is_a?(Array)
            rest.first.reduce(&block)
          elsif rest.size == 2 && rest.last.is_a?(Array)
            initial, acc = rest
            acc.reduce(initial, &block)
          else
            raise ArgumentError, 'Wrong Argument type'
          end
        end.curry.call
      end

      def self.foldr
        # foldr :: (a -> b) -> xs -> b
        proc do |block, *rest|
          if rest.size == 1 && rest.first.is_a?(Array)
            rest.first.reverse.reduce(&block)
          elsif rest.size == 2 && rest.last.is_a?(Array)
            initial, acc = rest
            acc.reverse.reduce(initial, &block)
          else
            raise ArgumentError, 'Wrong Argument type'
          end
        end.curry.call
      end
    end
  end
end
