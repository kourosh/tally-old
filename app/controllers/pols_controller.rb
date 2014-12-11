class PolsController < ApplicationController
  before_action :set_pol, only: [:show, :edit, :update, :destroy]

  # GET /pols
  # GET /pols.json
  def index
    @pols = Pol.all
  end

  # GET /pols/1
  # GET /pols/1.json
  def show
  end

  # GET /pols/new
  def new
    @pol = Pol.new
  end

  # GET /pols/1/edit
  def edit
  end

  # POST /pols
  # POST /pols.json
  def create
    @pol = Pol.new(pol_params)

    respond_to do |format|
      if @pol.save
        format.html { redirect_to @pol, notice: 'Pol was successfully created.' }
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
        format.html { redirect_to @pol, notice: 'Pol was successfully updated.' }
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
      format.html { redirect_to pols_url, notice: 'Pol was successfully destroyed.' }
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
      params[:pol]
    end
end
