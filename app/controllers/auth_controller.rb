require 'rest-client'

class AuthController < ApplicationController
  def new
    @client_id = ENV['CLIENT_ID']
  end

  def callback
    session_code = request.env['rack.request.query_hash']['code']

    result = RestClient.post('https://github.com/login/oauth/access_token',
                             {:client_id => ENV['CLIENT_ID'],
                              :client_secret => ENV['CLIENT_SECRET'],
                              :code => session_code},
                             :accept => :json)
    if result
      access_token = JSON.parse(result)['access_token']
      scopes = JSON.parse(result)['scope'].split(',')
      has_user_email_scope = scopes.include? 'read:user'

      if has_user_email_scope
        user_info = JSON.parse(RestClient.get('https://api.github.com/user', {:params => {:access_token => access_token}}))
        userInDb = User.where(:email => user_info['email']).first
        @user = nil
        if userInDb
          @user = userInDb
        else
          @user = User.new(:username => user_info['login'], :email => user_info['email'], :token => access_token)
          @user.save
        end
        redirect_to user_show_url :id => 1
      end
    end
  end
end
