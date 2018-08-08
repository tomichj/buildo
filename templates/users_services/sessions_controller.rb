class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create], raise: false
  before_action :require_no_authentication, only: [:new, :create]

  def new
  end

  def create
    warden.authenticate!(:oath_lockable, recall: "#{controller_path}#new")
    flash[:notice] = 'You have signed in'
    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
