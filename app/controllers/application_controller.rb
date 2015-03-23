class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception,
    if: Proc.new { |c| c.request.format =~ %r{application/json} }

    def confirgurebraintree
        Braintree::Configuration.environment = :sandbox
        Braintree::Configuration.merchant_id = ENV["braintree_merchant_id"]
        Braintree::Configuration.public_key = ENV["braintree_public_key"]
        Braintree::Configuration.private_key = ENV["braintree_private_key"]
    end

    # Get random UUID
    def get_random_token
        return SecureRandom.uuid
    end

    #Get customer ID from Stripe
    def get_stripe_customer_id
        return PaymentMethod.where(user_id: current_user.id).first.customer_id
    end

end
