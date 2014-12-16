class PolsController < ApplicationController
  before_action :set_pol, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:index, :show]

  # GET /pols
  # GET /pols.json
  def index
    @pols = Pol.all.includes(:event)
    respond_to do |format|
      format.html
      format.json { render json: @pols, status: 200 }
    end
  end

  # GET /pols/1
  # GET /pols/1.json
  def show
    @pol = Pol.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @pol }
    end
  end

  # GET /pols/1/edit
  def edit
    @pol = Pol.find(params[:id])
  end

  # POST /pols
  # POST /pols.json
  def create
    @pol = Pol.new(pol_params)

    respond_to do |format|
      if @pol.save
        format.html { redirect_to @pol, notice: 'Successfully created politician.' }
        format.json { render :show, status: :created, location: @pol }
      else
        format.html { render :new }
        format.json { render json: @pol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pols/1
  # PATCH/PUT /pols/1.json
  def update
    respond_to do |format|
      if @pol.update(pol_params)
        format.html { redirect_to @pol, notice: 'Successfully updated politician.' }
        format.json { render :show, status: :ok, location: @pol }
      else
        format.html { render :edit }
        format.json { render json: @pol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pols/1
  # DELETE /pols/1.json
  def destroy
    @pol.destroy
    respond_to do |format|
      format.html { redirect_to pols_url, notice: 'Politician was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pol
      @pol = Pol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pol_params
      params.require(:pol).permit(:firstname, :lastname, :in_office)
    end

  protected
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_or_request_with_http_token('posts') do |token, options|
        User.find_by(auth_token: token)
      end
    end
    
    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="posts"'
      respond_to do |format|
        format.json { render json: 'Bad credentials', status: 401 }
      end
    end

end
