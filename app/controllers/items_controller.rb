class ItemsController < ApplicationController

  # Display all items
  def index
    #Search Functionality
    #If search is empty, return all items
    #Else, return items that contain the search string
    @items = Item.search(params[:search])
  end

  # Show details of a specific item
  def show
    @item = Item.find(params[:id])
  end

  # Initialize a new item instance for form rendering
  def new
    @item = Item.new
  end

  # Form for editing an item
  def edit
    @item = Item.find(params[:id])
  end

  # Create a new item record
  def create
    @item = Item.new(item_params)
    @item.available = true

    # If there are existing items, set the new item ID to the next number.
    # Otherwise, set the ID to 1 for the first item.
    if Item.count != 0
      count = Item.last.id + 1
      @item.id = count
    else
      @item.id = 1
    end

    # Save the new item and redirect or render errors as necessary
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

  # Update an item's details
  def update
  end


  # Confirm deletion of an item
  def delete
    @item = Item.find(params[:id])
  end

  # Remove an item from the database
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully removed." }
      format.json { head :no_content }
    end
  end

  def checkout
    @item = Item.find(params[:id])

    if @item.available
      # Mark the item as unavailable
      @item.update_attribute(:available, false)

      # Create a new Transaction entry with the item's serial_number
      Transaction.create(email: current_user.email, serial_number: @item.serial_number)

      redirect_to items_path, notice: "Item checked out and transaction created."
    else
      redirect_to items_path, alert: "Item is already checked out."
    end
  end

  # Display all items that are available
  def member_items
    #Search Functionality
    #If search is empty, return all items with available set to True (This is the case for member inventory)
    #Otherwise, only return items that contains the search string and is available
    @items = Item.search(params[:search]).where(available: true)
  end

  def export
    @items = Item.all

    # respond_to do |format|
    #   format.csv {send_data @items.to_csv, filename: "items-#{Date.today}.csv"}
    # end
    send_data @items.to_csv, filename: "items-#{Date.today}.csv"
  end

  def import
    if params[:file].present?
      csv_text = File.read(params[:file].path)
      csv = CSV.parse(csv_text, headers: true)
      csv.each do |row|
        item_hash = row.to_hash
        item_hash["available"] = case item_hash["available"].downcase.strip
                                 when 'true', 't', '1'
                                   true
                                 else
                                   false # Default value when it's not explicitly true.
                                 end
        
        item = Item.find_or_create_by(id: item_hash["id"])
        item.update!(item_hash)
      end

      redirect_to items_path, notice: "Items imported successfully!"
    else
      redirect_to items_path, alert: "Please upload a CSV file."
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to items_path, alert: "There was an issue with importing items. Error: #{e.message}"
  end

  private

    # Strong parameters for item to prevent mass-assignment vulnerabilities
    def item_params
      params.require(:item).permit(:name, :serial_number, :description, :image, :available)
    end
end
