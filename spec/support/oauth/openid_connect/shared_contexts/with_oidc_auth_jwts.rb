RSpec.shared_context 'with oidc auth jwts' do
  let(:moment) { Time.now.utc }

  # identity provider
  let(:iss) { 'http://0.0.0.0:8180/realms/ideacrew' }
  # the client application
  let(:aud) { 'sbm-service' }
  # subject ID (the unique account ID
  let(:sub) { '2ac78128-0933-4ae6-b41e-5316930e3397' }
  # authentication method reference - how the user authenticated
  let(:amr) { ['pwd'] } # (they used a password)
  # the no more than once (detects id token injection)
  let(:nonce) { 'PdxaXTg_THsyna9wfYpsD-_qVpWjlyjjcl864K0wbxY' }
  # a hash of the access token (detects access token injection)
  let(:at_hash) { '2KxmL27CM9VC5eL6WkS1uw' }
  # the session ID
  let(:sid) { 'de71c582d82d286b5c6007d33da8184b' }
  # the time the user last authenticated
  let(:auth_time) { moment.to_i }
  # issued at
  let(:iat) { moment.to_i }
  # expiry
  let(:exp) { (moment + 3600.seconds).to_i }
  # not before
  let(:nbf) { 0 }


  let(:oidc_id_token_payload) do
    {
      iss: iss,
      aud: aud,
      sub: sub,
      auth_time: auth_time,
      iat: iat,
      exp: exp,
      nbf: nbf,
      amr: amr,
      nonce: nonce,
      at_hash: at_hash,
      sid: sid
    }
  end

  # TODO: Encode as JWT token
  let(:id_token) { oidc_id_token_payload }
  let(:access_token) { 'f90aac6a954b0b39d403c8cc2077cec054f6e26af8077bec1fbc97bd641b6f90' }
  let(:refresh_token) { 'kas9Da81Dfa8' }
  let(:token_type) { 'Bearer' }
  # Duration in seconds the access token is valid from the time of issuance
  let(:expires_in) { 3600 }

  let(:auth_inbound_request) do
    {
      access_token: access_token,
      id_token: id_token,
      refresh_token: refresh_token,
      token_type: token_type,
      expires_in: expires_in
    }
  end

  # OIDC user_info endpoint request and response
  let(:email) { 'tony@avengers.com' }
  let(:preferred_username) { 'anthonstark123' }
  let(:name) { 'Anthony Stark' }
  let(:given_name) { 'Anthony' }

  # Profile scope returns:
  #   name, family_name, given_name, middle_name, nickname, preferred_username, profile, picture, website,
  #   gender, birthdate, zoneinfo, locale, and updated_at
  let(:profile_scope_request) { { sub: sub, claim: profile } }
  let(:profile_scope_response_params) do
    { sub: sub, preferred_username: preferred_username, name: name, given_name: given_name }
  end
end
