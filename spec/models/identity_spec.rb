# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Accounts::Identity do
  let(:provider) { 'keycloak_openid' }
  let(:uid) { '09e6fe8b-6dbc-40ac-a893-c92a6f584676' }
  let(:email) { 'tony@avengers.com' }
  let(:first_name) { 'tony' }
  let(:last_name) { 'stark' }

  let(:required_params) { { provider: provider, uid: uid } }
  let(:optional_params) { { email: email, first_name: first_name, last_name: last_name } }

  describe 'attributes' do
    subject(:identity) { described_class.new(required_params) }

    it 'has the expected attributes' do
      expect(identity).to have_attributes(provider: provider, uid: uid)
    end

    context 'when optional attributes are present' do
      subject(:identity) { described_class.new(required_params.merge(optional_params)) }

      it 'has the expected attributes' do
        expect(identity).to have_attributes(
          provider: provider,
          uid: uid,
          email: email,
          first_name: first_name,
          last_name: last_name
        )
      end
    end
  end

  describe 'validations' do
    subject(:identity) { described_class.new(required_params.merge(optional_params)) }

    before { identity.valid? }

    it 'is valid with valid attributes' do
      expect(identity).to be_valid
    end

    context 'when required :provider value is missing' do
      let(:provider) { nil }

      it 'is invalid' do
        expect(identity).not_to be_valid
      end

      it 'has the expected error message' do
        expect(identity.errors[:provider]).to include('is not included in the list')
      end
    end

    context 'when required :uid value is missing' do
      let(:uid) { nil }

      it 'is invalid' do
        expect(identity).not_to be_valid
      end

      it 'has the expected error message' do
        expect(identity.errors[:uid]).to include("can't be blank")
      end
    end
  end

  describe 'associations' do
    it { is_expected.to be_embedded_in(:account).as_inverse_of(:identities) }
  end

  describe 'scopes' do
    describe '.default_scope' do
      it 'default scope can be applied to class' do
        expect(described_class).to be_default_scopable
      end

      # it 'orders by created_at in descending order' do
      #   expect(described_class.default_scope).to eq(described_class.order(created_at: :desc))
      # end
    end
  end

  describe 'class methods' do
    let(:account) { Accounts::Account.create(name: name, email: email) }
    let(:name) { 'tony@avengers.com' }
    let(:oauth) { { 'provider' => provider, 'uid' => uid } }

    describe '.find_or_initialize_with_oauth' do
      subject(:find_or_initialize_with_oauth) { described_class.find_or_initialize_with_oauth(oauth: oauth) }

      context 'when an identity exists' do
        let!(:existing_identity) { described_class.create(oauth.merge(account: account)) }

        it 'returns the found identity' do
          expect(find_or_initialize_with_oauth).to eq(existing_identity)
        end
      end

      context 'when an identity is not found' do
        it 'returns a new identity' do
          expect(find_or_initialize_with_oauth).to be_a_new(described_class)
        end
      end
    end

    describe '.find_by_oauth' do
      subject(:find_by_oauth) { described_class.find_by_oauth(oauth: oauth) }

      context 'when an identity is found' do
        let!(:identity) { described_class.create(oauth.merge!(account: account)) }

        it 'returns the found identity' do
          expect(find_by_oauth).to eq(identity)
        end
      end

      context 'when an identity is not found' do
        it 'returns nil' do
          expect(find_by_oauth).to be_nil
        end
      end
    end

    describe '.initialize_with_oauth' do
      subject(:initialize_with_oauth) { described_class.initialize_with_oauth(oauth: oauth) }

      it 'creates a new identity' do
        expect(initialize_with_oauth).to be_a_new(described_class)
      end
    end
  end
end
