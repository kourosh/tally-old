class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    #Take amount from the right place

    if params[:amount_entry] == ""
        amount = params[:amount_select]
    else
        amount = params[:amount_entry]
    end

    #Charge Stripe fees to customer

    final_float = amount.to_i + (amount.to_i * 0.029) + 30
    final_amount = final_float.round

    @transaction = Transaction.new(user_id: current_user.id, event_id: params[:event_id], amount: final_amount, support: params[:support])

    #Create the charge with Stripe

    charge = Stripe::Charge.create({
        :amount => final_amount,
        :currency => "usd",
        :customer => get_stripe_customer_id,
        :description => "Tally Contribution",
        :application_fee => 100
    },
    Pac.find(params[:pac_id]).stripe_secret_key
    )

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
end
