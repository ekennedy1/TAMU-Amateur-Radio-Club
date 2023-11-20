# frozen_string_literal: true

class ConsumablesController < ApplicationController
  before_action :set_consumable, only: %i[show edit update destroy]
  before_action :check_admin

  def index
    @consumables = Consumable.all
  end

  def show; end

  def new
    @consumable = Consumable.new
  end

  def edit; end

  def create
    @consumable = Consumable.new(consumable_params)
    if @consumable.save
      redirect_to @consumable, notice: 'Consumable was successfully created.'
    else
      render :new
    end
  end

  def update
    if @consumable.update(consumable_params)
      redirect_to @consumable, notice: 'Consumable was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @consumable = Consumable.find(params[:id])
    @consumable.destroy
    redirect_to consumables_url, notice: 'Consumable was successfully destroyed.'
  end

  private

  def set_consumable
    @consumable = Consumable.find(params[:id])
  end

  def consumable_params
    params.require(:consumable).permit(:name, :description, :quantity_remaining)
  end

  def check_admin
    redirect_to(root_path, alert: 'You are not authorized to view this page.') unless current_user&.admin?
  end
end
