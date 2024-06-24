# frozen_string_literal: true

class Organization
  include ActiveModel::Model

  attr_accessor :display_name, :name, :user_role, :user_authorities,
                :object_count, :storage_megabytes

  def admin?
    user_role == PreservationManager::Role::ADMIN
  end

  def primary_contact(proxy_header)
    $preservation_manager_proxy.describe_org_contact(name, proxy_header)
  end

  def self.find(name, proxy_header)
    org = $preservation_manager_proxy.describe_org(name, proxy_header)
    Organization.new({ display_name: org.display_name,
                       name: org.org_name,
                       user_role: org.role,
                       user_authorities: org.authorities })
  end

  # Returns all organizations the current user has access to along with the user's roles and
  # authorities
  def self.all(proxy_header)
    $preservation_manager_proxy.list_user_orgs(proxy_header).orgs.map do |org|
      Organization.new({ display_name: org[:displayName],
                         name: org[:orgName],
                         user_role: org[:role],
                         user_authorities: org[:authorities] })
    end
  end

  # Returns all organizations with the storage details for the organizations,
  # including aggregate storage information
  def self.all_with_storage(proxy_header)
    manager_response = $preservation_manager_proxy.get_system_storage(proxy_header)

    orgs = manager_response.organizations.map do |org|
      Organization.new({ display_name: org[:displayName],
                         name: org[:orgName],
                         object_count: org[:objectCount],
                         storage_megabytes: org[:storageMegabytes] })
    end

    { total_objects: manager_response.total_object_count,
      total_storage: manager_response.total_storage_megabytes,
      organizations: orgs }
  end
end
