class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :omniauthable, omniauth_providers: %i[openid_connect]
  devise :omniauthable, omniauth_providers: %i[openid_connect]

  # An Account has one or more identities. An identity is a set of credentials from a third-party Oidc2 provider.

  # Identities are credentials from third-party Oidc2 providers
  embeds_many :identities, class_name: 'Identity', inverse_of: :account, cascade_callbacks: true

  field :name, type: String
  field :email, type: String, default: ''

  accepts_nested_attributes_for :identities

  ## Devise Trackable attributes
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: DateTime
  field :last_sign_in_at, type: DateTime
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  # An Account has a unique name value. The account name is often an email address, but it can be any unique string.
  index({ name: 1 }, { unique: true })
  index({ email: 1 }, { unique: true, sparse: true })
  # Composite, unique index on provider and uid fields
  # index({ 'identities.uid': 1, 'identities.provider': 1 }, { unique: true })

  ## Devise Trackable attributes
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: DateTime
  field :last_sign_in_at, type: DateTime
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  scope :latest_identity, -> { identities.order(created_at: :desc).first }
  scope :latest_profile, -> { profiles.order(created_at: :desc).first }

  validates :name, presence: true, uniqueness: true
  # validates :identities, presence: true

  def self.find_or_initialize_with_id_token(id_token: nil)
    find_by_id_token(id_token: id_token) || initialize_with_id_token(id_token: id_token)
  end

  def self.find_by_id_token(id_token: nil)
    id_token.symbolize_keys!
    where(name: id_token[:name]).first
  end

  def self.initialize_with_id_token(id_token: nil)
    id_token.symbolize_keys!
    new(name: id_token[:name])
  end

  def link_to_oauth?(provider: nil)
    provider.present? ? identities.where(provider: provider).any? : identities.any?
  end
end
