class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find_by_id(params[:id])
  end


  # def show
  #   @user = User.find(params[:id])
  # end
end
