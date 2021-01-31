class SessionsController < ApplicationController
  def create
    session[:credentials] = auth_hash[:credentials]
    redirect_to new_post_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
