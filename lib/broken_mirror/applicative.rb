module BrokenMirror
  class Applicative
    def self.pure
      Proc.new do |val|
        self.new val
      end
    end

    def ap *args
      apply_to.(*args)
    end

    private

    def apply_to
      if @val.arity > 1
        @val.curry.()
      else
        @val
      end
    end

    def initialize(val)
      @val = val
    end
  end
end
