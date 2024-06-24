# frozen_string_literal: true

class PreservationObjectsController < ApplicationController
  before_action :set_vault

  def display
    @preservation_object = PreservationObject.find(params[:vault_id],
                                                   params[:preservation_object_id],
                                                   params[:version],
                                                   current_user.proxy_header)

    @events = @preservation_object.events(current_user.proxy_header)
    @storage_problems = @preservation_object.storage_problems(current_user.proxy_header)
  rescue PreservationManagerProxy::BadRequest, PreservationManagerProxy::NotFound
    not_found
  end

  private

  def set_vault
    @vault = Vault.find(params[:vault_id], current_user.proxy_header)
    current_organization(@vault.org_name)
  rescue PreservationManagerProxy::NotFound
    not_found
  end
end
