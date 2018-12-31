OmniAuth.config.full_host = Rails.env.production? ? 'https://morning-lake-67624.herokuapp.com/' : 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.google[:client_id], Rails.application.credentials.google[:client_secret], { scope: 'userinfo.email,userinfo.profile,https://www.google.com/m8/feeds', access_type: 'offline', approval_prompt: '', client_options: {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}} }
end
