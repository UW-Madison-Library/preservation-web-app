# frozen_string_literal: true

class VaultsController < ApplicationController
  before_action :set_vault, only: %i[show]

  def index
    @vaults = Vault.all(current_organization.name, current_user.proxy_header)
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def show
    @members = @vault.members(current_user.proxy_header)

    if @vault.user_access? || current_user.service_admin?
      batch_search_params = { vault: @vault.name,
                              state: PreservationManager::IngestBatchState::PENDING_REVIEW }

      @pending_batches_count = SearchBatches.new(batch_search_params,
                                                 current_organization.name,
                                                 current_user.proxy_header).call.total_results

      @objects_with_problems = @vault.objects_with_storage_problems(current_user.proxy_header)

      @search_response = SearchPreservationObjects.new(
        @vault.name, params[:preservation_object], current_user.proxy_header
      ).call

      render 'member_show'
    else
      render 'general_show'
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def new
    redirect_to organization_vaults_path unless current_organization.admin?
    @vault = Vault.new
  end

  def create
    @vault = Vault.new(vault_params)

    if @vault.save_vault(current_organization.name, current_user.proxy_header)
      notice = "Click 'Create New Batch' to start adding content to #{@vault.name}."
      redirect_to vault_path(@vault.name), notice: notice
    else
      redirect_to new_organization_vault_path, alert: error_notice(@vault.errors)
    end
  end

  private

  def set_vault
    @vault = Vault.find(params[:id], current_user.proxy_header)
    current_organization(@vault.org_name)
  rescue PreservationManagerProxy::NotFound
    not_found
  end

  def error_notice(errors)
    if errors.messages.present?
      errors.full_messages.first
    else
      'Vault is invalid, please try again.'
    end
  end

  # Only allow a list of trusted parameters through
  def vault_params
    params.fetch(:vault, {}).permit(:name, :description)
  end
end
