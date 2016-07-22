module BrokenMirror
  class Monoid
    def initialize(*val)
      @val = val
    end

    def empty
      @val.first
    end

    def concat(val2)
      self.class.new([@val.first] << val2)
    end
  end
end
