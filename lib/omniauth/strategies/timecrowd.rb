require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class TimeCrowd < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: 'https://api.timecrowd.net',
        authorize_url: '/oauth/authorize',
        token_url: '/oauth/token',
      }
      option :provider_ignores_state, true

      uid { raw_info['id'].to_s }

      info do
        {
          'nickname': raw_info['nickname'],
          'image': raw_info['image'],
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('api/v1/user/info').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'timecrowd', 'TimeCrowd'

