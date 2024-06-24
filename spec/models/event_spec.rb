# frozen_string_literal: true

require 'rails_helper'

describe Event do
  describe 'EVENT_TYPES' do
    it 'matches API event count' do
      expected = PreservationManager::EventType.constants.count
      actual = described_class::EVENT_TYPES.count
      expect(actual).to eq(expected)
    end

    it 'has all expected keys' do
      PreservationManager::EventType.constants.each do |curr_type|
        expect(described_class::EVENT_TYPES.include?(curr_type.to_s)).to be(true), "#{curr_type} missing"
      end
    end
  end
end
