=begin
#Preservation Manager Public API

#Public API for the Preservation Manager.

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.32
=end

require 'date'

module PreservationManager
  class Role
    STANDARD = 'STANDARD'.freeze
    ADMIN = 'ADMIN'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = Role.constants.select { |c| Role::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #Role" if constantValues.empty?
      value
    end
  end
end
