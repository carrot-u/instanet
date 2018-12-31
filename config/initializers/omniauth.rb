OmniAuth.config.full_host = Rails.env.production? ? 'https://morning-lake-67624.herokuapp.com/' : 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.google[:client_id], Rails.application.credentials.google[:client_secret] {
    scope: 'userinfo.email, userinfo.profile, plus.me',
    include_granted_scopes: true,
    callback_path: '/auth/google_oauth2/callback'
  }
end
end
