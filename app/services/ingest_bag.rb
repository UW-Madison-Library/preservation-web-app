# frozen_string_literal: true

IngestBagFailure = Struct.new(:error) do
  def success?
    false
  end
end

IngestBagSuccess = Struct.new(:batch_id) do
  def success?
    true
  end
end

class IngestBag
  require 'fileutils'

  MISSING_PARAM_MESSAGE = 'Please provide a bag and a vault.'
  BAD_REQUEST_MESSAGE = 'Batch creation failed, please try again.'
  TMPDIR_PREFIX = 'ingest_bag'

  def initialize(ingest_params, proxy_header)
    @upload = ingest_params[:bag]
    @vault = ingest_params[:vault]
    @proxy_header = proxy_header
  end

  def call
    unless @upload.present? && @vault.present?
      @upload.tempfile.unlink if @upload.present? && File.file?(@upload.tempfile)

      return IngestBagFailure.new(MISSING_PARAM_MESSAGE)
    end

    ingest_bag
  end

  private

  def ingest_bag
    Rails.logger.info { "ingest_bag received #{@upload.original_filename} for #{@vault}" }

    directory = Dir.mktmpdir(TMPDIR_PREFIX)

    opts = { vault: @vault, file: rename_file(directory) }.merge(@proxy_header)
    batch_id = $preservation_manager_proxy.ingest_bag(opts).ingest_id

    IngestBagSuccess.new(batch_id)
  rescue PreservationManagerProxy::BadRequest
    Rails.logger.error { "ingest_bag returned 400 BadRequest for #{@vault}, no batch was created" }

    IngestBagFailure.new(BAD_REQUEST_MESSAGE)
  ensure
    # Delete the directory and the file, force=true
    FileUtils.remove_entry_secure(directory, true)
  end

  # Returns a new File with the bag's original filename so that the file is in the correct format
  # for the Preservation Manager API
  def rename_file(directory)
    new_file_path = "#{directory}/#{@upload.original_filename}"

    File.rename(@upload.tempfile.path, new_file_path) if File.file?(@upload.tempfile.path)
    File.new(new_file_path) if File.file?(new_file_path)
  end
end
