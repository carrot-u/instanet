OmniAuth.config.full_host = Rails.env.production? ? 'https://morning-lake-67624.herokuapp.com/' : 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '43794107149-c50hui0brmkloib99edjjt3j1a9hrmlj.apps.googleusercontent.com', 'A0blDPBWaRaBVLGeMNmlz78J', { callback_path: '/auth/google_oauth2/callback' }
end
