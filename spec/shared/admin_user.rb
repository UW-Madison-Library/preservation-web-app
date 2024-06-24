# frozen_string_literal: true

RSpec.shared_context 'with admin user', shared_context: :metadata do
  before do
    stub_describe_user

    org1 = Organization.new(name: 'org1',
                            display_name: 'Organization 1',
                            user_role: PreservationManager::Role::ADMIN,
                            user_authorities: %w[ADMIN_OPS BASIC_OPS])
    allow(Organization).to receive(:find).and_return(org1)
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'with admin user', include_shared: true
end
