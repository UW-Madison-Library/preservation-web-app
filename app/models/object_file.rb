# frozen_string_literal: true

class ObjectFile
  include ActiveModel::Model

  attr_reader :path, :sha_256_digest, :file_size, :format_array, :encoding_array, :validity_array

  def initialize(file)
    @path = file[:filePath]
    @sha_256_digest = file[:sha256Digest]
    @file_size = file[:fileSize]
    @format_array = file[:formats].map { |file_format| initialize_format(file_format) }
    @encoding_array = file[:encoding]
    @validity_array = file[:validity].map { |validity| initialize_validity(validity) }
  end

  private

  def initialize_format(file_format)
    { format_registry: file_format[:formatRegistry],
      file_format: file_format[:format],
      source: file_format[:source] }
  end

  def initialize_validity(validity)
    { valid: validity[:valid],
      well_formed: validity[:wellFormed],
      source: validity[:source] }
  end
end
