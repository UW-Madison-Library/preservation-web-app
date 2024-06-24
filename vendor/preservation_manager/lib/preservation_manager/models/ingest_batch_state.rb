=begin
#Preservation Manager Public API

#Public API for the Preservation Manager.

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.32
=end

require 'date'

module PreservationManager
  class IngestBatchState
    RECEIVED = 'RECEIVED'.freeze
    ANALYZING = 'ANALYZING'.freeze
    ANALYSIS_FAILED = 'ANALYSIS_FAILED'.freeze
    PENDING_REVIEW = 'PENDING_REVIEW'.freeze
    PENDING_INGESTION = 'PENDING_INGESTION'.freeze
    PENDING_REJECTION = 'PENDING_REJECTION'.freeze
    INGESTING = 'INGESTING'.freeze
    INGEST_FAILED = 'INGEST_FAILED'.freeze
    REPLICATING = 'REPLICATING'.freeze
    REPLICATION_FAILED = 'REPLICATION_FAILED'.freeze
    COMPLETE = 'COMPLETE'.freeze
    REJECTING = 'REJECTING'.freeze
    REJECTED = 'REJECTED'.freeze
    DELETED = 'DELETED'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = IngestBatchState.constants.select { |c| IngestBatchState::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #IngestBatchState" if constantValues.empty?
      value
    end
  end
end
