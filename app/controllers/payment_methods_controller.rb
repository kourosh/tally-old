class PaymentMethodsController < ApplicationController

	def new
	end

	def create
		customer = Stripe::Customer.create(
			source: params[:payment_token]
		)

		PaymentMethod.create(user_id: current_user.id, customer_id: customer.id)

		redirect_to "/events"
	end

	def check
		payment_method = PaymentMethod.where(user_id: current_user.id).try(:first)
	
		if payment_method
			render :json => { result: "ok" }
		else
			render :json => { result: "error", error: "There is no payment method associated with this account." }
		end
	end

end
