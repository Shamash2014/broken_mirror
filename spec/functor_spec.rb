require 'spec_helper'
describe BrokenMirror::Functor do
  context 'laws' do
    let(:fmap) { BrokenMirror::Functor.fmap }
    let(:id)  { BrokenMirror::Identity.id }

    let(:double) do
      ->(x) { x * 2 }
    end

    let(:triple) do
      ->(x) { x * 3 }
    end

    let(:compose) { BrokenMirror::Pipe.compose }

    context 'callable' do
     it 'respond to call' do
        expect(fmap).to respond_to(:call)
      end
    end

    it 'satisfy identity law' do
      expect(fmap.(id).(3)).to eql 3
      expect(fmap.(id).(5)).to eql 5
    end

    it 'satisfy composition law' do
      expect(fmap.(compose.(double, triple)).(1)).to eql(compose.(fmap.(double), fmap.(triple)).(1))
      expect(fmap.(compose.(double, triple)).(4)).to eql(compose.(fmap.(double), fmap.(triple)).(4))
    end
  end
end
