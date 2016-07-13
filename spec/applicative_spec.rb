require 'spec_helper'
describe BrokenMirror::Applicative do
  let(:pure) { BrokenMirror::Applicative.pure }

  let(:combine) do
    ->(x, y, z) { x + y + z }
  end

  it 'pure return new Applicative instance' do
    expect(pure.(combine).class).to eql BrokenMirror::Applicative
  end

  it 'ap will apply contextualised function to arguments' do
    expect(pure.(combine).ap.(1).(2).(3)).to eql 6
    expect(pure.(combine).ap(10).(20).(30)).to eql 60
  end
end
