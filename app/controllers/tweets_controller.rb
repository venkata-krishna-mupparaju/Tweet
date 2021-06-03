class TweetsController < ApplicationController
  before_action :authenticate, only: [:index, :new, :create]
  require 'will_paginate/array' 


  def index
    @tweets = client.user_timeline.paginate(:page => params[:page], :per_page => 5)
  end

  def new
  end

  def create
    client.update(params[:body])
  	redirect_to tweets_path
  	flash[:success] = "Created Tweet Successfully"
  end

end
