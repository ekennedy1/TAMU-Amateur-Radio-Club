class AdminController < ApplicationController
  before_action :set_user, only: [:update]
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
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      redirect_to admin_users_path, alert: 'User was not created.'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      redirect_to admin_users_path, alert: 'User was not updated.'
    end
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
      redirect_to admin_users_path, alert: 'User not found.'
  end

  def transactions
    @transactions = Transaction.all
  end

  private

  # Strong parameters
  def user_params
    params.require(:user).permit(:fname, :lname, :email, :role, :password, :password_confirmation)
  end


  def ensure_admin
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "Access denied!"
    end
  end
end
