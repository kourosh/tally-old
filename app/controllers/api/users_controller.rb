module API
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :confirgurebraintree, only: [:create, :index, :show]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def attempt_login
    
    user = User.where(email: params[:user][:email]).first
    user_auth = user.authenticate(params[:user][:password])
    respond_to do |format|
      if user_auth
        user_auth.set_auth_token
        user_auth.save
        format.json { render json: user_auth, status: :ok }
      else
        format.json { head :no_content }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    full_street_address = params[:user][:user_street_address] + ", " + params[:user][:user_city] + ", " + params[:user][:user_state] + " " + params[:user][:user_zip]
    geocode_results = Geokit::Geocoders::GoogleGeocoder.geocode(full_street_address)
    user_parameters = user_params.merge(latitude: geocode_results.lat, longitude: geocode_results.lng)

    @user = User.new(user_parameters)

    respond_to do |format|
      if @user.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      respond_to do |format|
        if @user.update(user_params)
          format.json { render :show, status: :ok, location: @user }
        else
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
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
end