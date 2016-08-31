require 'spec_helper'

describe BrokenMirror::Monad do
  context 'laws' do
    let (:unite) { BrokenMirror::Monad.method(:unite) }
    let (:new_monad) { unite.call(1) }

    let(:double) do
      ->(x) { x * 2 }
    end

    it 'satisfy left identity law' do
      expect(unite.call(1).bind(double).empty).to eql(double.call(1))
    end

    it 'satisfy right identity law' do
      expect(unite.call(new_monad)).to eql new_monad
    end
  end
end
