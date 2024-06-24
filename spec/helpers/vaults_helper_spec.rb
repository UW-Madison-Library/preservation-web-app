# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VaultsHelper, type: :helper do
  describe VaultsHelper do
    let :curr_user_display do
      'Current User'
    end

    describe 'format_display_names' do
      it 'returns display name' do
        display = helper.format_display_names([curr_user_display], curr_user_display)
        member_list = "<div class=\"member_list\"><span class=\"current_user\">#{curr_user_display}</span></div>"

        expect(display).to eq(member_list)
      end

      it 'returns three display names' do
        display = helper.format_display_names(['User 1', curr_user_display, 'User 2'], curr_user_display)
        member_list = "<div class=\"member_list\"><span class=\"current_user\">#{curr_user_display}, </span><span>User 1, User 2</span></div>"

        expect(display).to eq(member_list)
      end

      it 'returns non-current user display names' do
        display = helper.format_display_names(['User 4', 'User 1', 'User 3', 'User 2'], curr_user_display)
        member_list = '<div class="member_list"><span>User 1, User 2, User 3, User 4</span></div>'

        expect(display).to eq(member_list)
      end
    end

    describe 'user_vaults' do
      it 'returns empty array' do
        vault1 = Vault.new({ name: 'vault1',
                             description: 'valid description',
                             user_permissions: [] })

        expect(user_vaults([vault1])).to be_empty
      end

      it 'returns user vaults sorted alphabetically' do
        vault1 = Vault.new({ name: 'vault1',
                             description: 'valid description',
                             user_permissions: [] })

        vault2 = Vault.new({ name: 'vault2',
                             description: 'valid description',
                             user_permissions: %w[READ WRITE] })

        vault3 = Vault.new({ name: 'a third vault',
                             description: 'valid description',
                             user_permissions: %w[READ] })
        expect(user_vaults([vault1, vault2, vault3])).to eq([vault3, vault2])
      end
    end

    describe 'no_access_vaults' do
      it 'returns empty array' do
        vault1 = Vault.new({ name: 'vault1',
                             description: 'valid description',
                             user_permissions: %w[READ WRITE] })

        expect(no_access_vaults([vault1])).to be_empty
      end

      it 'returns vaults sorted alphabetically' do
        vault1 = Vault.new({ name: 'vault1',
                             description: 'valid description',
                             user_permissions: [] })

        vault2 = Vault.new({ name: 'vault2',
                             description: 'valid description',
                             user_permissions: %w[READ WRITE] })

        vault3 = Vault.new({ name: 'a third vault',
                             description: 'valid description',
                             user_permissions: %w[] })
        expect(no_access_vaults([vault1, vault2, vault3])).to eq([vault3, vault1])
      end
    end
  end
end
