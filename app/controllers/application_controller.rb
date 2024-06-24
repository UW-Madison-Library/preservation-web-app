# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :current_organization

  before_action :current_user

  before_action :ensure_user

  rescue_from PreservationManagerProxy::Forbidden, with: :forbidden_user

  rescue_from PreservationManagerProxy::NotFound, with: :not_found

  def current_organization(org_name = nil)
    @current_organization ||= Organization.find(org_name || params[:organization_id],
                                                current_user.proxy_header)
  end

  def current_user
    @current_user ||= User.new
  end

  private

  def ensure_user
    current_user.populate_user_details
  end

  def forbidden_user
    render file: Rails.public_path.join('403.html'), layout: false, status: :forbidden
  end

  def not_found
    render file: Rails.public_path.join('404.html'), layout: false, status: :not_found
  end
end
