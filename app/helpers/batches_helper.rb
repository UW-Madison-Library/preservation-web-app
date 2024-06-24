# frozen_string_literal: true

module BatchesHelper
  def batch_header(batch)
    batch.review_required? ? "Review Batch #{batch.id}" : "Batch #{batch.id}"
  end

  def batch_item_header(batch, vault_list)
    if batch.review_required? && vault_member?(vault_list, batch.vault)
      link_to batch_header(batch), edit_batch_path(batch.id)
    elsif vault_member?(vault_list, batch.vault)
      link_to batch_header(batch), batch_path(batch.id)
    else
      batch_header(batch)
    end
  end

  def disabled(vault)
    vault.user_write_access? ? '' : 'disabled'
  end

  def batch_review_legend(vault)
    if vault.user_write_access?
      'Approve or Reject Batch'
    else
      'Only Vault Contributors May Submit Review'
    end
  end

  def bounce_animation
    content_tag(:div, class: 'dot_loading') do
      concat content_tag(:div, '', class: ['bounce1'])
      concat content_tag(:div, '', class: ['bounce2'])
      concat content_tag(:div, '', class: ['bounce3'])
    end
  end

  def vault_member?(vault_list, vault_name)
    vault_list.each do |vault|
      return vault.user_access? if vault.name == vault_name
    end

    false
  end
end
