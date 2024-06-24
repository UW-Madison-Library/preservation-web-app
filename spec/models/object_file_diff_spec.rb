# frozen_string_literal: true

require 'rails_helper'

describe ObjectFileDiff do
  let(:empty_diff) do
    { added: [], removed: [], unchanged: [] }
  end

  describe 'new' do
    context 'with empty hash' do
      it 'returns nil or empty array for all attributes' do
        expected = { path: nil, new_sha_256_digest: nil, old_sha_256_digest: nil, diff_state: nil,
                     format_diff: [], validity_diff: [], encoding_diff: [] }

        object_file_diff = described_class.new({ formatDiff: empty_diff,
                                                 validityDiff: empty_diff,
                                                 encodingDiff: empty_diff })

        expect(object_file_diff).to have_attributes(expected)
      end
    end
  end

  describe 'initialize encoding_diff' do
    it 'creates encoding diff object' do
      diff = { added: %w[US-ASCII ISO-8859-1], removed: [], unchanged: [] }
      object_file_diff = described_class.new({ formatDiff: empty_diff,
                                               validityDiff: empty_diff,
                                               encodingDiff: diff }).encoding_diff

      expected_iso = { status: described_class::DIFF_DISPLAY_NAME[:added], encoding: 'ISO-8859-1' }
      expected_ascii = { status: described_class::DIFF_DISPLAY_NAME[:added], encoding: 'US-ASCII' }

      expect(object_file_diff).to contain_exactly(expected_iso, expected_ascii)
    end

    context 'when added, removed, and unchanged are empty' do
      it 'returns empty array' do
        object_file_diff = described_class.new({ formatDiff: empty_diff,
                                                 validityDiff: empty_diff,
                                                 encodingDiff: empty_diff })

        expect(object_file_diff.encoding_diff).to be_empty
      end
    end
  end

  describe 'initialize format_diff' do
    it 'creates format diff object' do
      diff = { added: [], unchanged: [], removed: [{ format: 'text/plain', registry: 'MIME' }] }
      object_file_diffs = described_class.new({ formatDiff: diff,
                                                validityDiff: empty_diff,
                                                encodingDiff: empty_diff }).format_diff

      expected_format = { status: described_class::DIFF_DISPLAY_NAME[:removed],
                          file_format: 'text/plain',
                          registry: 'MIME' }

      expect(object_file_diffs).to contain_exactly(expected_format)
    end

    context 'when removed, and added are empty' do
      it 'returns empty array' do
        diff = { added: [], removed: [], unchanged: [{ format: 'text/plain', registry: 'MIME' }] }
        object_file_diff = described_class.new({ formatDiff: diff,
                                                 validityDiff: empty_diff,
                                                 encodingDiff: empty_diff })

        expect(object_file_diff.format_diff).to be_empty
      end
    end

    context 'when added, removed, and unchanged are empty' do
      it 'returns empty array' do
        object_file_diff = described_class.new({ formatDiff: empty_diff,
                                                 validityDiff: empty_diff,
                                                 encodingDiff: empty_diff })

        expect(object_file_diff.format_diff).to be_empty
      end
    end
  end

  describe 'initialize validity_diff' do
    it 'creates validity diff object' do
      diff = { added: [{ valid: true, wellFormed: true }],
               removed: [],
               unchanged: [{ valid: false, wellFormed: false }] }
      validity_diff = described_class.new({ formatDiff: empty_diff,
                                            validityDiff: diff,
                                            encodingDiff: empty_diff }).validity_diff

      added_diff = { status: described_class::DIFF_DISPLAY_NAME[:added],
                     valid: true,
                     well_formed: true }

      unchanged_diff = { status: described_class::DIFF_DISPLAY_NAME[:unchanged],
                         valid: false,
                         well_formed: false }

      expect(validity_diff).to contain_exactly(added_diff, unchanged_diff)
    end

    context 'when added, removed, and unchanged are empty' do
      it 'returns empty array' do
        object_file_diff = described_class.new({ formatDiff: empty_diff,
                                                 validityDiff: empty_diff,
                                                 encodingDiff: empty_diff })

        expect(object_file_diff.validity_diff).to be_empty
      end
    end
  end
end
