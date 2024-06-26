=begin
#Preservation Manager Public API

#Public API for the Preservation Manager.

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.32
=end

require 'date'

module PreservationManager
  class JobType
    RETRIEVE_OBJECTS = 'RETRIEVE_OBJECTS'.freeze
    REPLICATE = 'REPLICATE'.freeze
    RESTORE = 'RESTORE'.freeze
    FINALIZE_RESTORE = 'FINALIZE_RESTORE'.freeze
    VALIDATE_LOCAL = 'VALIDATE_LOCAL'.freeze
    PROCESS_BATCH = 'PROCESS_BATCH'.freeze
    VALIDATE_REMOTE = 'VALIDATE_REMOTE'.freeze
    DELETE_DIP = 'DELETE_DIP'.freeze
    CLEANUP_SIPS = 'CLEANUP_SIPS'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = JobType.constants.select { |c| JobType::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #JobType" if constantValues.empty?
      value
    end
  end
end
