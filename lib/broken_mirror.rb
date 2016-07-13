# frozen_string_literal: false
require "broken_mirror/version"
require 'broken_mirror/functor'
require 'broken_mirror/compose'

module BrokenMirror
  module Identity
    # id :: a -> a

    def self.id
      Proc.new { |x| x }
    end
  end

  module Bifunctor
    def self.bimap
      Proc.new{ |f, g, x, y|
        [f.(x), g.(y)]
      }.curry.()
    end
  end

  module Foldable
    def self.foldl
      Proc.new do |block, *rest|
        if rest.size == 1 && rest.first.is_a?(Array)
          rest.first.reduce(&block)
        elsif rest.size == 2 && rest.last.is_a?(Array)
          initial, acc = rest
          acc.reduce(initial, &block)
        else
          raise ArgumentError, 'Wrong Argument type'
        end
      end.curry.()
    end

    def self.foldr
      Proc.new do |block, *rest|
        if rest.size == 1 && rest.first.is_a?(Array)
          rest.first.reverse.reduce(&block)
        elsif rest.size == 2 && rest.last.is_a?(Array)
          initial, acc = rest
          acc.reverse.reduce(initial, &block)
        else
          raise ArgumentError, 'Wrong Argument type'
        end
      end.curry.()
    end
  end

  class Applicative
    def self.pure val
      self.new val
    end

    def ap *args
      chain.(*args)
    end

    private

    def chain
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

  class Monoid
    def initialize(val)
      @val = [val]
    end

    def empty
      @val.first
    end

    def concat(val2)
      self.class.new(@val.concat(val2))
    end
  end

  class Chain
    def self.lift val
      self.new val
    end

    def bind
      -> (f) { self.class.new(f.call(@value)) }
    end

    private

    def initialize(val)
      @val = val
    end
  end

  class Monad
    def self.pure val
      self.new val
    end

    def bind(block)
      self.class.new(block.call(@val.first))
    end

    def join val
      if val.class == 'Monad'
        self.class.new val.out.first
      else
        self.class.new val.first
      end
    end

    def out(where=self)
      @val
    end

    private

    def initialize(val)
      @val = [val]
    end
  end
end
