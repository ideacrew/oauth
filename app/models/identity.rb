# frozen_string_literal: true

module Accounts
  # An individual or service, uniquely identified by provider and uid, authenticated by a trusted
  # id_token2 Service Provider
  class Identity
    include Mongoid::Document
    include Mongoid::Timestamps

    AVAILABLE_PROVIDERS = %w[openid_connect].freeze
    # OIDC_MAP = { provider: iss, uid: sub }

    embedded_in :account, class_name: 'Accounts::Account', inverse_of: :identities

    # identity.provider + identity.uid comprise id_token2 Provider-assigned unique identifier
    field :provider, type: String
    field :uid, type: String

    field :email, type: String
    field :first_name, type: String
    field :last_name, type: String

    validates :uid, presence: true, uniqueness: { scope: :provider }
    validates :provider, presence: true, inclusion: { in: AVAILABLE_PROVIDERS }

    default_scope -> { order(created_at: :desc) }

    def self.id_token_to_oath(id_token = {})
      { provider: id_token[:iss], uid: id_token { :sub } }
    end

    def self.find_or_initialize_with_id_token(id_token: nil)
      find_by_id_token(id_token: id_token) || initialize_with_id_token(id_token: id_token)
    end

    def self.find_by_id_token(id_token: nil)
      id_token.symbolize_keys!
      account = Accounts::Account.where('identities.uid': id_token[:uid], 'identities.provider': id_token[:provider]).first
      account&.identities&.where(uid: id_token[:uid], provider: id_token[:provider])&.first
    end

    def self.initialize_with_id_token(id_token: nil)
      id_token.symbolize_keys!
      new(uid: id_token[:uid], provider: id_token[:provider])
    end
  end
end
