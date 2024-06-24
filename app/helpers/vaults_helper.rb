# frozen_string_literal: true

module VaultsHelper
  def user_vaults(vaults)
    vaults.select(&:user_access?).sort_by { |vault| vault.name.downcase }
  end

  def no_access_vaults(vaults)
    vaults.reject(&:user_access?).sort_by { |vault| vault.name.downcase }
  end

  def format_display_names(display_names, curr_user)
    content_tag(:div, class: 'member_list') do
      if display_names.include?(curr_user)
        display_names.delete(curr_user)
        user_display = display_names.count.positive? ? "#{curr_user}, " : curr_user

        concat content_tag(:span, user_display, class: ['current_user'])
      end

      concat content_tag(:span, display_names.sort.join(', ')) if display_names.count.positive?
    end
  end
end
