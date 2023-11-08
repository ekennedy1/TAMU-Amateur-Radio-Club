# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
  end

  def users
    @users = User.all
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User created successfully!"
    else
      redirect_to admin_users_path, alert: "User creation failed!"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    # Remove password params if they are blank
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end


  def user_params
    params.require(:user).permit(:fname, :lname, :email, :role, :password, :password_confirmation, :callsign)
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
