require 'spec_helper'


describe BrokenMirror::Monoid do
  let (:monoid) { described_class.new(1) }

  context 'it satisfy laws' do
    it { expect(monoid.empty).to eql 1 }
    it { expect(monoid.concat(2).empty).to eql [1, 2] }
  end
end
