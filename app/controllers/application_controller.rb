class ApplicationController < ActionController::Base
   
  def validate_user
    request_token = OAuth::RequestToken.new(consumer, session[:request_token], session[:request_token_secret])
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    session[:access_token_key] = access_token.token
    session[:access_token_secret] = access_token.secret

    redirect_to tweets_path
  end


  def authenticate
    unless session[:access_token_key] && session[:access_token_secret]
      request_token = consumer.get_request_token(:oauth_callback => "http://localhost:3000/validate_user")
      session[:request_token] = request_token.token
      session[:request_token_secret] = request_token.secret

      redirect_to request_token.authorize_url
    end
  end

  def client
    Twitter::REST::Client.new(
      :consumer_key => ENV['CONSUMER_KEY'],
      :consumer_secret => ENV['CONSUMER_SECRET_KEY'],
      :access_token => session[:access_token_key],
      :access_token_secret => session[:access_token_secret]
    )
  end

  private

  def consumer
    OAuth::Consumer.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET_KEY'], {
      :site => "https://api.twitter.com"
    })
  end
end
