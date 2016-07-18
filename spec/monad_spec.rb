require 'spec_helper'

describe BrokenMirror::Monad do
  context 'laws' do
    let (:pure) { BrokenMirror::Monad.method(:pure) }
    let (:new_monad) { pure.call(1) }

    let(:double) do
      ->(x) { x * 2 }
    end

    it 'satisfy left identity law' do
      expect(pure.call(1).bind(double).empty).to eql(double.call(1))
    end

    it 'satisfy right identity law' do
      expect(pure.call(new_monad)).to eql new_monad
    end
  end
end
