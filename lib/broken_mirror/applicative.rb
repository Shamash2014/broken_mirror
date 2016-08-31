module BrokenMirror
  class Applicative
    private_class_method :new
    def self.unite
      proc do |val|
        new val
      end
    end

    def ap(*args)
      apply_to.call(*args)
    end

    private

    def apply_to
      if @val.arity > 1
        @val.curry.call
      else
        @val
      end
    end

    def initialize(val)
      @val = val
    end
  end
end
