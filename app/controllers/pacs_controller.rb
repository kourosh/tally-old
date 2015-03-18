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
      @pac = Pac.new(pac_params)

      respond_to do |format|
        if @pac.save
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
        if @pac.update(pac_params)
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

  private

    def set_pac
      @pac = Pac.find(params[:id])
    end

    def pac_params
      params.require(:pac).permit(:committee_id, :committee_name, :affiliated_party, :pac_email)
    end
end
