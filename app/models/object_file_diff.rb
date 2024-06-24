# frozen_string_literal: true

class ObjectFileDiff
  attr_reader :path, :new_sha_256_digest, :old_sha_256_digest, :diff_state, :format_diff,
              :validity_diff, :encoding_diff

  DIFF_DISPLAY_NAME = { added: 'added', removed: 'removed', unchanged: 'unchanged' }.freeze

  def initialize(diff)
    @path = diff[:path]
    @diff_state = diff[:diff]
    @new_sha_256_digest = diff[:newSha256Digest]
    @old_sha_256_digest = diff[:oldSha256Digest]
    @format_diff = initialize_format_diff(diff[:formatDiff])
    @validity_diff = initialize_validity_diff(diff[:validityDiff])
    @encoding_diff = initialize_encoding_diff(diff[:encodingDiff])
  end

  def modified?
    diff_state == 'MODIFIED'
  end

  def removed?
    diff_state == 'REMOVED'
  end

  def sha_digest_changed?
    new_sha_256_digest != old_sha_256_digest
  end

  private

  def initialize_format_diff(diff)
    return [] if no_changes?(diff)

    diff_arr = []

    diff.each_key do |key|
      diff[key].each do |format_hash|
        diff_arr << { status: DIFF_DISPLAY_NAME[key],
                      file_format: format_hash[:format],
                      registry: format_hash[:registry] }
      end
    end

    diff_arr
  end

  def initialize_encoding_diff(diff)
    return [] if no_changes?(diff)

    diff_arr = []

    diff.each_key do |key|
      diff[key].each do |encoding|
        diff_arr << { status: DIFF_DISPLAY_NAME[key], encoding: encoding }
      end
    end

    diff_arr
  end

  def initialize_validity_diff(diff)
    return [] if no_changes?(diff)

    diff_arr = []

    diff.each_key do |key|
      diff[key].each do |validity_hash|
        diff_arr << { status: DIFF_DISPLAY_NAME[key],
                      valid: validity_hash[:valid],
                      well_formed: validity_hash[:wellFormed] }
      end
    end

    diff_arr
  end

  # Diffs can have values for added, removed, and unchanged.
  # If there are NO values for added and removed, then values for unchanged can be ignored and
  # no changes should be displayed to the user.
  def no_changes?(diff)
    diff[:added].empty? && diff[:removed].empty?
  end
end
