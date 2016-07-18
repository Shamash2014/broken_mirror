module BrokenMirror
  # Monad instance can be created usin pure
  # Every monad operation can be chained over monad
  # Monad has a join method, which will extract value from it
  # Given monad is a monoid, you can get value from monad using empty
  # Then method primary used for callbacks
  class Monad
    # pure :: a -> Monad a
    def self.pure(val)
      unless val.respond_to?(:bind)
        new val
      else
        val
      end
    end

    # bind :: (a -> b) -> Proc -> Monad a -> Monad b
    def bind(block)
      self.class.new(block.call(@val.first))
    end

    # join :: [a] -> Monad a
    def join(val)
      if val.class == 'BrokenMirror::Monad'
        self.class.new val.empty
      else
        self.class.new val.first
      end
    end

    # then :: (a -> b) -> Proc -> m a -> m b -> m b
    def then(block)
      self.class.pure block.call
    end

    def empty(_where = self)
      @val.first
    end

    private

    def initialize(val)
      @val = [val]
    end
  end
end
