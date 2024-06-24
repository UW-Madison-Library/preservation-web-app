# frozen_string_literal: true

class OrganizationsController < ApplicationController
  def index
    if current_user.service_admin?
      orgs_with_storage = Organization.all_with_storage(current_user.proxy_header)
      @total_objects = orgs_with_storage[:total_objects]
      @total_storage = orgs_with_storage[:total_storage]

      @organizations = orgs_with_storage[:organizations]

      render 'service_admin_index', layout: 'organization_index'
    else
      @user_organizations = Organization.all(current_user.proxy_header)
      render layout: 'organization_index'
    end
  end

  def show
    # sets @current_organization
    current_organization(params[:id])

    @primary_contact = @current_organization.primary_contact(current_user.proxy_header)
  end
end
