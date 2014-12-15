class PoliticiansController < ApplicationController
	@politicians = Pol.all
	# @politicians = Pol.order(:fullname).where("fullname like ?", "%#{params[:term]}%")
    render json: @politicians.map(&:fullname)
end
