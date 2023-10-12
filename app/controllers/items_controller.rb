class ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new()
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.available = true
    if Item.count != 0
      count = Item.last.id + 1
      @item.id = count
    else
      @item.id = 1
    end
    
    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
        flash[:notice] = "Successfully created item"
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def delete
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully removed." }
      format.json { head :no_content }
    end
  end

  def member_items
    @items = Item.where(available: true)
  end

  private
    def item_params 
      params.require(:item).permit(:name, :serial_number, :description)
    end
end
