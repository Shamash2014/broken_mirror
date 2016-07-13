module BrokenMirror
  # Functor provide only one method -> fmap
  # Functor's fmap curried by default
  # Functor behaviour specified only for callable interface
  # Morphism must be callable and return value
  module Functor
    # fmap :: (a -> b) -> Proc a -> Proc b

    def self.fmap
      Proc.new do |block, val|
        block.call(val)
      end.curry.()
    end
  end
end
