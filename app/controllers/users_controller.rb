# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit; end

  def user_edit
    @user = User.find(params[:id])
  end
  # def show
  #   @user = User.find(params[:id])
  # end
end
