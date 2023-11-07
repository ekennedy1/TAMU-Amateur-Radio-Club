# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index; end

  def users
    @users = User.all
  end

  def transactions
    @transactions = Transaction.all
  end

  private

  def ensure_admin
    return if current_user&.admin?

    redirect_to root_path, alert: 'Access denied!'
  end
end
