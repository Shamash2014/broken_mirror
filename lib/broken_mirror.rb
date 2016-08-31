# frozen_string_literal: false
require 'broken_mirror/version'
require 'broken_mirror/functor'
require 'broken_mirror/compose'
require 'broken_mirror/applicative'
require 'broken_mirror/monad'
require 'broken_mirror/monoid'
require 'broken_mirror/chain'
require 'broken_mirror/foldable'

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
end
