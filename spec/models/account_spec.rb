# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::Account do
  let(:provider) { 'keycloak_openid' }
  let(:uid) { '09e6fe8b-6dbc-40ac-a893-c92a6f584676' }
  let(:identities) { [Accounts::Identity.new(provider: provider, uid: uid)] }

  let(:name) { 'tony@avengers.com' }
  let(:email) { name }

  let(:required_params) { { name: name, identities: identities } }
  let(:optional_params) { { email: email } }
  let(:all_params) { required_params.merge(optional_params) }

  describe 'attributes' do
    subject(:account) { described_class.new(all_params) }

    it 'has the expected attributes' do
      expect(account).to have_attributes(name: name, email: email, identities: identities)
    end

    context 'when optional :email value is missing' do
      let(:email) { nil }

      it 'has the expected attributes' do
        expect(account).to have_attributes(name: name, email: nil, identities: identities)
      end
    end
  end

  describe 'validations' do
    subject(:account) { described_class.new(all_params) }

    before { account.valid? }

    it 'is valid with valid attributes' do
      expect(account).to be_valid
    end

    context 'when required :name value is missing' do
      let(:name) { nil }

      it 'is invalid' do
        expect(account).not_to be_valid
      end

      it 'has the expected error message' do
        expect(account.errors[:name]).to include("can't be blank")
      end
    end

    context 'when required :identities value is missing' do
      let(:identities) { nil }

      it 'is invalid' do
        expect(account).not_to be_valid
      end

      it 'has the expected error message' do
        expect(account.errors[:identities]).to include("can't be blank")
      end
    end
  end

  describe 'associations' do
    it { is_expected.to embed_many(:identities) }
  end

  describe 'class methods' do
    let(:oauth) { { name: name, identities: identities } }

    describe '.find_by_oauth' do
      subject(:find_by_oauth) { described_class.find_by_oauth(oauth: oauth) }

      context 'when an account exists' do
        let!(:existing_account) { described_class.create(name: name, identities: identities) }

        it 'returns the found account' do
          expect(find_by_oauth).to eq(existing_account)
        end
      end

      context 'when an account is not found' do
        it 'returns nil' do
          expect(find_by_oauth).to be_nil
        end
      end
    end

    describe ',initialize_with_oauth' do
      subject(:initialize_with_oauth) { described_class.initialize_with_oauth(oauth: required_params) }

      it 'returns a new account' do
        expect(initialize_with_oauth).to be_a_new(described_class)
      end

      it 'with the name attribute set' do
        expect(initialize_with_oauth).to have_attributes(name: name)
      end
    end

    describe '.find_or_initialize_with_oauth' do
      subject(:find_or_initialize_with_oauth) { described_class.find_or_initialize_with_oauth(oauth: required_params) }

      context 'when an account exusts' do
        let!(:existing_account) { described_class.create(required_params) }

        it 'returns the found account' do
          expect(find_or_initialize_with_oauth).to eq(existing_account)
        end
      end

      context 'when an account is not found' do
        it 'returns a new account' do
          expect(find_or_initialize_with_oauth).to be_a_new(described_class)
        end

        it 'with the name attribute set' do
          expect(find_or_initialize_with_oauth).to have_attributes(name: name)
        end
      end
    end
  end
end
