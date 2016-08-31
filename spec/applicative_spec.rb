require 'spec_helper'
describe BrokenMirror::Applicative do
  let(:unite) { BrokenMirror::Applicative.unite }

  let(:combine) do
    ->(x, y, z) { x + y + z }
  end

  it 'pure return new Applicative instance' do
    expect(unite.call(combine).class).to eql BrokenMirror::Applicative
  end

  it 'ap will apply contextualised function to arguments' do
    expect(unite.call(combine).ap.call(1).call(2).call(3)).to eql 6
    expect(unite.call(combine).ap(10).call(20).call(30)).to eql 60
  end
end
