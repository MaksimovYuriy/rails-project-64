# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    resource = warden.authenticate(auth_options)
    if resource.nil?
      flash[:warning] = I18n.t('devise.sessions.sign_in_error')
    end

    super

    flash.clear
    flash[:success] = I18n.t('devise.sessions.signed_in')
  end

  # DELETE /resource/sign_out
  def destroy
    super do |_resource|
      flash.clear
      flash[:success] = I18n.t('devise.sessions.signed_out')
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
