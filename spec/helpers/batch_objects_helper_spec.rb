# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BatchObjectsHelper. For example:
#
# describe BatchObjectsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BatchObjectsHelper, type: :helper do
  describe 'find_object_file' do
    it 'returns an object file' do
      object_files = [ObjectFile.new({ filePath: 'path1.txt', formats: [], encoding: [], validity: [] }),
                      ObjectFile.new({ filePath: 'path2.txt', formats: [], encoding: [], validity: [] })]

      found_object = find_object_file(object_files, 'path2.txt')

      expect(found_object).to be(object_files.last)
    end
  end

  describe 'analysis_text' do
    it 'returns error message' do
      expect(analysis_text(true, true)).to eq('Errors Detected')
      expect(analysis_text(true, false)).to eq('Errors Detected')
    end

    it 'returns warning message' do
      expect(analysis_text(false, true)).to eq('Warnings Detected')
    end

    it 'returns default text' do
      expect(analysis_text(false, false)).to eq('No errors or warnings were detected.')
    end
  end

  describe 'sorted_file_diffs' do
    it 'returns sorted data' do
      empty_diffs = { formatDiff: { added: [], removed: [], unchanged: [] },
                      encodingDiff: { added: [], removed: [], unchanged: [] },
                      validityDiff: { added: [], removed: [], unchanged: [] } }

      diff_one = ObjectFileDiff.new({ path: 'one.txt', diff: 'ADDED' }.merge(empty_diffs))
      diff_two = ObjectFileDiff.new({ path: 'two.txt', diff: 'ADDED' }.merge(empty_diffs))
      diff_three = ObjectFileDiff.new({ path: 'three.txt', diff: 'MODIFIED' }.merge(empty_diffs))
      diff_four = ObjectFileDiff.new({ path: 'four.txt', diff: 'REMOVED' }.merge(empty_diffs))
      diff_five = ObjectFileDiff.new({ path: 'five.txt', diff: 'UNCHANGED' }.merge(empty_diffs))

      file_diffs = [diff_five, diff_three, diff_one, diff_four, diff_two]

      expected = [['ADDED', [diff_one, diff_two]],
                  ['MODIFIED', [diff_three]],
                  ['REMOVED', [diff_four]],
                  ['UNCHANGED', [diff_five]]]

      expect(sorted_file_diffs(file_diffs)).to eq(expected)
    end

    it 'returns empty array' do
      expect(sorted_file_diffs([])).to eq([])
    end
  end

  describe 'dropdown_range' do
    it 'returns first page range' do
      total_results = SearchBatchObjects::PAGE_SIZE + 1
      expect(dropdown_range(0, total_results)).to eq("1 - #{SearchBatchObjects::PAGE_SIZE}")
    end

    it 'returns final results range' do
      total_results = SearchBatchObjects::PAGE_SIZE + 1
      start_range = SearchBatchObjects::PAGE_SIZE + 1
      expect(dropdown_range(1, total_results)).to eq("#{start_range} - #{total_results}")
    end
  end
end
