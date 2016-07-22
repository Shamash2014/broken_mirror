# frozen_string_literal: false
require 'broken_mirror/version'
require 'broken_mirror/functor'
require 'broken_mirror/compose'
require 'broken_mirror/applicative'
require 'broken_mirror/monad'
require 'broken_mirror/monoid'
require 'broken_mirror/chain'

module BrokenMirror
  module Identity
    # id :: a -> a

    def self.id
      proc { |x| x }
    end
  end

  module Bifunctor
    def self.bimap
      proc do |f, g, x, y|
        [f.call(x), g.call(y)]
      end.curry
    end
  end

  module Foldable
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
