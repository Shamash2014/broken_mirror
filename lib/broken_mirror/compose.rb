module BrokenMirror
  # Function composition is the act of pipelining the result of one function,
  # to the input of another, creating an entirely new function.
  module Compose
    # compose :: (b -> c) -> (a -> b) -> a -> c
    def self.compose
      Proc.new do |f, g|
        -> (*args) { g.(f.(*args)) }
      end.curry.()
    end
  end
end
