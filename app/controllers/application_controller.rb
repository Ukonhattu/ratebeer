# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Top level controller for rails

  #before_action :authenticate

  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'you should be signed in' if current_user.nil?
  end

  def ensure_that_admin
    redirect_to signin_path, notice: 'you should be admin' if current_user.admin != true
  end

end
