# frozen_string_literal: true

class User
  attr_accessor :display_name, :username, :user_type

  def proxy_header
    { header_params: { 'X-PROXY-FOR' => 'admin-1@example.com' } }
  end

  def service_admin?
    user_type == PreservationManager::UserType::SERVICE_ADMIN
  end

  def populate_user_details
    user_details = $preservation_manager_proxy.describe_user(proxy_header).user

    @display_name = user_details[:displayName]
    @username = user_details[:username]
    @user_type = user_details[:userType]
  end
end
