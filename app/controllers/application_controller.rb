# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Top level controller for rails

  before_action :authenticate

  private

  def authenticate
    admin_accounts = { 'pekka' => 'beer', 'arto' => 'foobar', 'matti' => 'ittam', 'vilma' => 'kangas' }
    authenticate_or_request_with_http_basic do |username, password|
      admin_accounts[username] == password
    end
  end
end
