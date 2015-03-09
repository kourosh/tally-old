class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :user_first_name, :user_last_name, :user_street_address, :user_city, :user_state, :user_zip, :user_phone, :occupation, :employer_name, :unemployed_or_retired, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :user_first_name, :user_last_name, :user_street_address, :user_city, :user_state, :user_zip, :user_phone, :occupation, :employer_name, :unemployed_or_retired, :password, :password_confirmation, :current_password)
  end
end
