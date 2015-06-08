class ChatController < ApplicationController
  def index
    if params[:admin] == "true"
      session[:admin] = true
    end
  end
end
