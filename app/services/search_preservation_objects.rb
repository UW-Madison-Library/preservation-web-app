# frozen_string_literal: true

SearchPreservationObjectsFailure = Struct.new(:error) do
  def success?
    false
  end
end

SearchPreservationObjectsSuccess = Struct.new(:preservation_object) do
  def success?
    true
  end
end

class SearchPreservationObjects
  START_SEARCH_MESSAGE = 'Enter a preservation object identifier to view object details.'
  NOT_FOUND_MESSAGE = 'Sorry, no results were found.'

  def initialize(vault, preservation_object_id, proxy_header)
    @vault = vault
    @preservation_object_id = preservation_object_id&.strip
    @proxy_header = proxy_header
  end

  def call
    if @preservation_object_id.blank?
      return SearchPreservationObjectsFailure.new(START_SEARCH_MESSAGE)
    end

    pres_obj = $preservation_manager_proxy.describe_preservation_object(@vault,
                                                                        @preservation_object_id,
                                                                        @proxy_header)

    SearchPreservationObjectsSuccess.new(PreservationObject.new(pres_obj))
  rescue PreservationManagerProxy::NotFound
    SearchPreservationObjectsFailure.new(NOT_FOUND_MESSAGE)
  end
end
