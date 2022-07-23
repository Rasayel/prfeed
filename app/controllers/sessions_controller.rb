# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    if session[:user].present?
      redirect_to root_path
    else
      render :new
    end
  end

  def create
    auth = request.env["omniauth.auth"]
    token = auth.dig("credentials", "token")
    user = ::Warden::GitHub::User.load(token)
    if user && user.organization_member?(Rails.application.secrets.github_organization)
      session[:user] = user.login
      redirect_to root_path
    else
      Rails.logger.error("User #{user.login} is not a member of #{Rails.application.secrets.github_organization}")
      render :new
    end
  end
end
