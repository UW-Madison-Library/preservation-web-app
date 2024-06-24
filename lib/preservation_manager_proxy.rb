# frozen_string_literal: true

require 'custom_errors/forbidden'
require 'custom_errors/bad_request'
require 'custom_errors/not_found'

module PreservationManagerProxy
  # The PreservationManager client is generated from OpenAPI defintions. The ruby generator only
  # creates one error, ApiError. This proxy class maps the error code to a custom error,
  # which allows for unique error handling and reduces repeated code in controllers and models.
  class PreservationManagerProxy
    def initialize(preservation_manager)
      @preservation_manager = preservation_manager
    end

    def method_missing(method, ...)
      @preservation_manager.send(method, ...)
    rescue PreservationManager::ApiError => e
      match_error(e.code)
    end

    def respond_to_missing?(method_name, include_private = false)
      @preservation_manager.respond_to?(method_name, include_private)
    end

    private

    def match_error(error_code)
      case error_code
      when 400
        raise BadRequest
      when 401, 403
        raise Forbidden
      when 404
        raise NotFound
      else
        raise
      end
    end
  end
end
