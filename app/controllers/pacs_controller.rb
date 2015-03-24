class PacsController < ApplicationController
  before_action :set_pac, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  def index
    if current_user.admin?
      @pacs = Pac.all
    end
  end

  def new
    if current_user.admin?
      @pac = Pac.new
    end
  end

  def create
    if current_user.admin?
      signup_token = get_random_token

      pac_parameters = pac_params.merge(signup_token: signup_token)

      @pac = Pac.new(pac_parameters)

      respond_to do |format|
        if @pac.save
          UserMailer.pac_signup(@pac).deliver
          format.html { redirect_to @pac, notice: 'Successfully created pac.' }
        else
          format.html { render :new }
        end
      end
    end
  end

  def show
    if current_user.admin?
      @pac = Pac.find(params[:id])
      respond_to do |format|
        format.html
      end
    end
  end


  def edit
    if current_user.admin?
      @pac = Pac.find(params[:id])
    end
  end


  def update
    if current_user.admin?
      respond_to do |format|
        if @pac.update_attributes(pac_params)
          format.html { redirect_to @pac, notice: 'Successfully updated pac.' }
        else
          format.html { render :edit }
        end
      end
    end
  end


  def destroy
    if current_user.admin?
      @pac.destroy
      respond_to do |format|
        format.html { redirect_to pacs_url, notice: 'pac was successfully destroyed.' }
      end
    end
  end

  def confirm
    if params[:code]
      request = Typhoeus::Request.new(
        "https://connect.stripe.com/oauth/token",
        method: :post,
        params: {
          client_secret: Rails.application.secrets.stripe_sk,
          code: params[:code],
          grant_type: "authorization_code"
        }
      )

      request.run

      stripe_data = JSON.parse(request.response.body)

      stripe_secret_key = stripe_data["access_token"]
      stripe_publishable_key = stripe_data["stripe_publishable_key"]
      stripe_user_id = stripe_data["stripe_user_id"]

      this_pac = Pac.where(signup_token: session[:signup_token]).first

      if this_pac.update_attributes(stripe_secret_key: stripe_secret_key, stripe_publishable_key: stripe_publishable_key, stripe_user_id: stripe_user_id)
        flash[:success] = "Awesome! You're all set to receive payments with Tally"
      end

    elsif params[:signup_token]
      session[:signup_token] = params[:signup_token]
    else
      redirect_to "/"
    end
  end

  private

    def set_pac
      @pac = Pac.find(params[:id])
    end

    def pac_params
      params.require(:pac).permit(:committee_id, :committee_name, :affiliated_party, :pac_email, :ideology, :address, :city, :state, :zip, :affiliated_candidate)
    end
end
