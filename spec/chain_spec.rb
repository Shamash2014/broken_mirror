require 'spec_helper'

describe BrokenMirror::Chain do
  let(:lifted) {  described_class.lift(1) }
  let(:double) { ->(x) { x * 2 } }

  it 'obey laws'do
    expect(lifted.bind.(double).empty).to eql 2
  end
end
