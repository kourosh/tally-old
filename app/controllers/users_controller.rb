class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    # before_action :confirgurebraintree, only: [:new, :create]

    # GET /users
    # GET /users.json
    def index
        @users = User.all
    end

    def attempt_login
        @user = User.where(email: params[:user][:email], password: params[:user][:password]).first
        respond_to do |format|
            if @user
                @user.set_auth_token
                @user.save
                format.json { render json: @user }
            else
                format.json { head :no_content, status: 404 }
            end
        end
    end

    # GET /users/1
    # GET /users/1.json
    def show
    end

    # GET /users/new
    def new
        @user = User.new
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users
    # POST /users.json
    def create
        full_street_address = params[:user_street_address] + ", " + params[:user_city] + ", " + params[:user_state] + " " + params[:user_zip]
        geocode_results = Geokit::Geocoders::GoogleGeocoder.geocode(full_street_address)
        user_parameters = user_params.merge(latitude: geocode_results.lat, longitude: geocode_results.lng)

        @user = User.new(user_parameters)

        respond_to do |format|
            if @user.save
                format.json { render :show, status: :created, location: @user }
            else
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
    # result = Braintree::Customer.create(
    #   :payment_method_nonce => params[:nonce],
    #   :customer_id => @user.id
    #   )
    if result.success?
        respond_to do |format|
            if @user.update(user_params)
                format.json { render :show, status: :ok, location: @user }
            else
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    else
        p result.errors
    end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
        @user.destroy
        respond_to do |format|
            format.json { head :no_content }
        end
    end

    def settings_index
        payment_method = PaymentMethod.where(user_id: current_user.id).try(:first)

        if payment_method
            customer = Stripe::Customer.retrieve(payment_method.customer_id)
            @payment_info = customer.sources.data[0]
        end
    end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(:email, :user_first_name, :user_last_name, :user_street_address, :user_city, :user_state, :user_zip, :user_phone, :occupation, :employer_name, :unemployed_or_retired, :password)
    end
end
