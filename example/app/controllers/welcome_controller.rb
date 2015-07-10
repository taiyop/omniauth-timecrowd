class WelcomeController < ApplicationController
  def index
    if auth.present?
      @signed_in = true
      @nickname = auth.info.nickname
      @image = auth.info.image
      set_teams
    end
  end

  private
    def auth
      request.env['omniauth.auth']
    end

    def set_teams
      token = auth.credentials.token

      client = OAuth2::Client.new(ENV['TIMECROWD_CLIENT_ID'], ENV['TIMECROWD_CLIENT_SECRET'], site: ENV['TIMECROWD_SITE'], ssl: { verify: false })
      access_token = OAuth2::AccessToken.new(client, token)

      @teams = access_token.get('api/v1/teams').parsed
    end
end
