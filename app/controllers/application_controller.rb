class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  acts_as_token_authentication_handler_for User, fallback: :none

  before_filter :configure_permitted_parameters, if: :devise_controller?
    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :displayname,
              :firstname, :lastname, :phonenumber, :address, :zipcode, :city, :password, :password_confirmation,
              :state, :country, :customertoken, :provider, :uid, :access_code, :publishable_key,
              :reviewpercentage, :is_admin, :is_cyclops) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :displayname,
              :firstname, :lastname, :phonenumber, :address, :zipcode, :city, :password, :password_confirmation,
              :state, :country, :customertoken, :provider, :uid, :access_code, :publishable_key,
              :reviewpercentage, :is_admin, :is_cyclops, :current_password) }
        end
end
