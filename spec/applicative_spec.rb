require 'spec_helper'
describe BrokenMirror::Applicative do
  let(:pure) { BrokenMirror::Applicative.pure }

  let(:combine) do
    ->(x, y, z) { x + y + z }
  end

  it 'pure return new Applicative instance' do
    expect(pure.call(combine).class).to eql BrokenMirror::Applicative
  end

  it 'ap will apply contextualised function to arguments' do
    expect(pure.call(combine).ap.call(1).call(2).call(3)).to eql 6
    expect(pure.call(combine).ap(10).call(20).call(30)).to eql 60
  end
end
