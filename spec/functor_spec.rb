require 'spec_helper'
describe BrokenMirror::Functor do
  context 'laws' do
    let(:fmap) { BrokenMirror::Functor.fmap }
    let(:id) { BrokenMirror::Identity.id }

    let(:double) do
      ->(x) { x * 2 }
    end

    let(:triple) do
      ->(x) { x * 3 }
    end

    let(:compose) { BrokenMirror::Compose.compose }

    context 'callable' do
      it 'respond to call' do
        expect(fmap).to respond_to(:call)
      end
    end

    it 'satisfy identity law' do
      expect(fmap.call(id).call(3)).to eql 3
      expect(fmap.call(id).call(5)).to eql 5
    end

    it 'satisfy composition law' do
      expect(fmap.call(compose.call(double, triple)).call(1)).to eql(compose.call(fmap.call(double), fmap.call(triple)).call(1))
      expect(fmap.call(compose.call(double, triple)).call(4)).to eql(compose.call(fmap.call(double), fmap.call(triple)).call(4))
    end
  end
end
