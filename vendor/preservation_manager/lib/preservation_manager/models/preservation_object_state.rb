=begin
#Preservation Manager Public API

#Public API for the Preservation Manager.

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.32
=end

require 'date'

module PreservationManager
  class PreservationObjectState
    ACTIVE = 'ACTIVE'.freeze
    DELETED = 'DELETED'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = PreservationObjectState.constants.select { |c| PreservationObjectState::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #PreservationObjectState" if constantValues.empty?
      value
    end
  end
end
