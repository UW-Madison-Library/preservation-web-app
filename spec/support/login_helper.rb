# frozen_string_literal: true

module LoginHelper
  def stub_describe_user
    general_user = { user: { username: 'user-1',
                             displayName: 'User 1',
                             enabled: true,
                             userType: PreservationManager::UserType::GENERAL_USER } }

    allow($preservation_manager_proxy).to receive(:describe_user)
      .and_return(PreservationManager::DescribeUserResponse.new(general_user))
  end

  def stub_unauthorized_user
    allow($preservation_manager_proxy).to receive(:describe_user)
      .and_raise(PreservationManagerProxy::Forbidden)
  end

  def test_user_proxy_header
    { header_params: { 'X-PROXY-FOR' => 'user-1@example.com' } }
  end
end
