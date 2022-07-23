# frozen_string_literal: true
class AuthenticatedController < ApplicationController
  before_action :authenticate_user!

  private

  def current_user
    @current_user ||= session[:user]
  end

  def authenticate_user!
    session[:user] = "test" if Rails.env.development?

    redirect_to login_path unless current_user
  end
end
