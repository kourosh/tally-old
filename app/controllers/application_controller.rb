class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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
end
