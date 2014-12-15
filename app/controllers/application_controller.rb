class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def confirgurebraintree
    Braintree::Configuration.environment = :sandbox
    Braintree::Configuration.merchant_id = "847dwb2bdvzhsd7s"
    Braintree::Configuration.public_key = "7dvzjtcdgyzyts23"
    Braintree::Configuration.private_key = "45e1ea9f9b99f05c33dfdb99f923632c"
  end
end
