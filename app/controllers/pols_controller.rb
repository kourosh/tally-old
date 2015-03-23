
  class PolsController < ApplicationController
    before_action :set_pol, only: [:show, :edit, :update, :destroy]
    # before_action :authenticate, except: [:index, :show]
    before_action :authenticate_user!, except: [:index, :show]

  # GET /pols
  # GET /pols.json
  def index
    @pols = Pol.includes(:events).all
    respond_to do |format|
      format.html
    end
  end


  def new
    if current_user.admin?
      @pol = Pol.new
    end
  end

  # POST /pols
  # POST /pols.json
  def create
    if current_user.admin?
      @pol = Pol.new pol_params

      respond_to do |format|
        if @pol.save
          format.html { redirect_to @pol, notice: 'Successfully created politician.' }
        else
          format.html { render :new }
        end
      end
    end
  end

    # GET /pols/1
  # GET /pols/1.json
  def show
    @pol = Pol.includes(:events).find(params[:id])
    if current_user
      @favorited = current_user.favorites.where(favorited_id: @pol.id).first
    end
    @comments = @pol.comments
    respond_to do |format|
      format.html
    end
  end

  # GET /pols/1/edit
  def edit
    if current_user.admin?
      @pol = Pol.find(params[:id])
    end
  end

  # PATCH/PUT /pols/1
  # PATCH/PUT /pols/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @pol.update pol_params
          format.html { redirect_to @pol, notice: 'Successfully updated politician.' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  # DELETE /pols/1
  # DELETE /pols/1.json
  def destroy
    if current_user.admin?
      @pol.destroy
      respond_to do |format|
        format.html { redirect_to pols_url, notice: 'Politician was successfully destroyed.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pol
      @pol = Pol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pol_params
      params.require(:pol).permit(:firstname, :lastname)
    end

    # protected
    # def authenticate
    #   authenticate_token || render_unauthorized
    # end

    # def authenticate_token
    #   authenticate_or_request_with_http_token('posts') do |token, options|
    #     User.find_by(auth_token: token)
    #   end
    # end

    # def render_unauthorized
    #   self.headers['WWW-Authenticate'] = 'Token realm="posts"'
    #   respond_to do |format|
    #     format.json { render json: 'Bad credentials', status: 401 }
    #   end
    # end
  end

