require 'omniauth'

# Configure Devise OmniAuth for test mode using OpenID Connect (OIDC) for testing
OmniAuth.configure do |config|
  config.test_mode = true

  # Set the spec to redirect to the /auth/failure endpoint when a strategy fails
  config.on_failure = proc { |env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure }


  # identity provider
  iss = 'http://0.0.0.0:8180/realms/ideacrew'
  # the client application
  aud = 'sbm-service'
  # subject ID (the unique account ID
  sub = '2ac78128-0933-4ae6-b41e-5316930e3397'
  # authentication method reference - how the user authenticated
  amr = ['pwd'] # (they used a password)
  # the no more than once (detects id token injection)
  nonce = 'PdxaXTg_THsyna9wfYpsD-_qVpWjlyjjcl864K0wbxY'
  # a hash of the access token (detects access token injection)
  at_hash = '2KxmL27CM9VC5eL6WkS1uw'
  # the session ID
  sid = 'de71c582d82d286b5c6007d33da8184b'
  # the time the user last authenticated
  moment = Time.now.utc
  auth_time = moment.to_i
  # issued at
  iat = moment.to_i
  # expiry
  exp = (moment + 3600.seconds).to_i
  # not before
  nbf = 0

  oidc_id_token_payload = {
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

  config.mock_auth[:openid_connect] = OmniAuth::AuthHash.new(
    oidc_id_token_payload
  )
end
