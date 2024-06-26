=begin
#Preservation Manager Public API

#Public API for the Preservation Manager.

OpenAPI spec version: 1.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.32
=end

require 'date'

module PreservationManager
  class OrgAuthority
    BASIC_OPS = 'BASIC_OPS'.freeze
    ADMIN_OPS = 'ADMIN_OPS'.freeze

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      constantValues = OrgAuthority.constants.select { |c| OrgAuthority::const_get(c) == value }
      raise "Invalid ENUM value #{value} for class #OrgAuthority" if constantValues.empty?
      value
    end
  end
end
