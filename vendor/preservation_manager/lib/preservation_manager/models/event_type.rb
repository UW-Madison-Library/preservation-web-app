=begin
#Preservation Manager Public API

#Public API for the Preservation Manager.

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.32
=end

require 'date'

module PreservationManager
  class EventType
    RECEIVE_BAG = 'RECEIVE_BAG'.freeze
    VIRUS_SCAN_BAG = 'VIRUS_SCAN_BAG'.freeze
    VALIDATE_BAG = 'VALIDATE_BAG'.freeze
    IDENTIFY_OBJ = 'IDENTIFY_OBJ'.freeze
    IDENTIFY_FILE_FORMAT = 'IDENTIFY_FILE_FORMAT'.freeze
    REVIEW_OBJ = 'REVIEW_OBJ'.freeze
    REVIEW_BATCH = 'REVIEW_BATCH'.freeze
    WRITE_OBJ_LOCAL = 'WRITE_OBJ_LOCAL'.freeze
    CREATE_OBJ = 'CREATE_OBJ'.freeze
    UPDATE_OBJ = 'UPDATE_OBJ'.freeze
    UPDATE_OBJ_METADATA = 'UPDATE_OBJ_METADATA'.freeze
    REPLICATE_OBJ_VERSION = 'REPLICATE_OBJ_VERSION'.freeze
    COMPLETE_OBJ_INGEST = 'COMPLETE_OBJ_INGEST'.freeze
    COMPLETE_BATCH_INGEST = 'COMPLETE_BATCH_INGEST'.freeze
    DELETE_BAG = 'DELETE_BAG'.freeze
    VALIDATE_OBJ_LOCAL = 'VALIDATE_OBJ_LOCAL'.freeze
    VALIDATE_OBJ_VERSION_LOCAL = 'VALIDATE_OBJ_VERSION_LOCAL'.freeze
    VALIDATE_OBJ_VERSION_REMOTE = 'VALIDATE_OBJ_VERSION_REMOTE'.freeze
    RESTORE_OBJ_VERSION = 'RESTORE_OBJ_VERSION'.freeze
    PREPARE_DIP = 'PREPARE_DIP'.freeze
    DELETE_OBJ = 'DELETE_OBJ'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = EventType.constants.select { |c| EventType::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #EventType" if constantValues.empty?
      value
    end
  end
end
