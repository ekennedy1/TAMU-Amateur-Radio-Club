# frozen_string_literal: true

class MaintenanceItemsController < ApplicationController
  before_action :set_maintenance_item, only: %i[show edit update destroy]

  # GET /maintenance_items or /maintenance_items.json
  def index
    @maintenance_items = MaintenanceItem.all
  end

  # GET /maintenance_items/1 or /maintenance_items/1.json
  def show
    @maintenance_item = MaintenanceItem.find(params[:id])
  end

  # GET /maintenance_items/new
  def new
    @maintenance_item = MaintenanceItem.new
  end

  # GET /maintenance_items/1/edit
  def edit
    @maintenance_item = MaintenanceItem.find(params[:id])
  end

  # POST /maintenance_items or /maintenance_items.json
  def create
    @maintenance_item = MaintenanceItem.new(maintenance_item_params)

    respond_to do |format|
      if @maintenance_item.save
        format.html do
          redirect_to maintenance_item_url(@maintenance_item), notice: 'Maintenance item was successfully created.'
        end
        format.json { render :show, status: :created, location: @maintenance_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @maintenance_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_items/1 or /maintenance_items/1.json
  def update
    respond_to do |format|
      if @maintenance_item.update(maintenance_item_params)
        format.html do
          redirect_to maintenance_item_url(@maintenance_item), notice: 'Maintenance item was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @maintenance_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @maintenance_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_items/1 or /maintenance_items/1.json
  def destroy
    @maintenance_item.destroy

    respond_to do |format|
      format.html { redirect_to maintenance_items_url, notice: 'Maintenance item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_maintenance_item
    @maintenance_item = MaintenanceItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def maintenance_item_params
    params.require(:maintenance_item).permit(:item_name, :description, :total_amount, :available_amount)
  end
end
