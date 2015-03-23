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

end
