module BrokenMirror
  class Chain
    # Chain allow to lift some value to the pipe

    # lift :: a -> Chain a
    def self.lift(val)
      new val
    end

    # empty :: Chain a -> a
    def empty
      @val
    end

    # bind :: (a -> b) -> f a -> Chain b
    def bind
      ->(f) { self.class.new(f.call(@val)) }
    end

    private

    def initialize(val)
      @val = val
    end
  end
end
