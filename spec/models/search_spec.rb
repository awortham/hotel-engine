require 'rails_helper'

describe Search do
  describe '#criteria' do
    let!(:search) { Search.create(criteria: '?query=frozen&page=1') }

    it 'is valid' do
      expect(search).to be_valid
    end

    context 'uniqueness' do
      let(:invalid_search) { Search.new(criteria: '?query=frozen&page=1') }

      it 'is not valid' do
        expect(invalid_search).to_not be_valid
        expect(invalid_search.errors.full_messages.to_sentence).to eq "Criteria has already been taken"
      end
    end

    context 'presence' do
      let(:invalid_search) { Search.new }

      it 'is not valid' do
        expect(invalid_search).to_not be_valid
        expect(invalid_search.errors.full_messages.to_sentence).to eq "Criteria can't be blank"
      end
    end
  end
end
