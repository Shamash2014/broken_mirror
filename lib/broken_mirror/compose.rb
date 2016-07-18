module BrokenMirror
  # Function composition is the act of pipelining the result of one function,
  # to the input of another, creating an entirely new function.
  module Compose
    # compose :: (b -> c) -> (a -> b) -> a -> c
    def self.compose
      proc do |f, g|
        -> (*args) { g.call(f.call(*args)) }
      end.curry.call
    end
  end
end
