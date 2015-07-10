Rails.application.config.middleware.use OmniAuth::Builder do
  provider :timecrowd, ENV['TIMECROWD_CLIENT_ID'], ENV['TIMECROWD_CLIENT_SECRET'], client_options: { site: ENV['TIMECROWD_SITE'], }
end
OmniAuth.config.logger = Rails.logger

