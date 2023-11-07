class TransactionsController < ApplicationController
  
    def index
      @transactions = Transaction.all
    end
  
    def show
      @transaction = Transaction.find(params[:id])
    end
  
    def new
      @transaction = Transaction.new()
    end
  
    def edit
    end
  
    def create
      @transaction = Transaction.new(transaction_params)
      @transaction.approved = false

      if Transaction.count != 0
        count = Transaction.last.id + 1
        @transaction.id = count
      else
        @transaction.id = 1
      end
      
      respond_to do |format|
        if @transaction.save
          format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
          format.json { render :show, status: :created, location: @transaction }
          #call mailer
          UserMailer.with(user: @transaction.email, item: @transaction.serial_number).checkout_email.deliver_later
          flash[:notice] = "Successfully created transaction"
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
    end

  
    def delete
      @transaction = Transaction.find(params[:id])
    end
  
    def destroy
      @transaction = Transaction.find(params[:id])
      @transaction.destroy
  
      respond_to do |format|
        format.html { redirect_to transactions_url, notice: "Transaction was successfully removed." }
        format.json { head :no_content }
      end
    end

    def approve
      @transaction = Transaction.find(params[:id])
    
      redirect_to transactions_path, notice: "Transaction was approved."
    end
  
    private
      def transaction_params 
        params.require(:transaction).permit(:email, :serial_number)
      end
  end