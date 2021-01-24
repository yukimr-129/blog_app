# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new
    super
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.naw[:alert] = @user.errors.full_messages
      render :new
      return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    redirect_to profiles_path
  end


  def new_profile
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new
  end

  def create_profile
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(profile_params)
    # バリデーションチェック
    unless @profile.valid?
      flash.naw[:alert] = @profile.errors.full_messages
      render :new_profile
      return
    end
    
    @user.save
    @profile = Profile.new(profile_params.merge(user_id: @user.id))
    @profile.save

    session["devise.regist_data"]["user"].clear
    sign_in @user

    redirect_to root_url
  end


  private

  def profile_params
    params.require(:profile).permit(:nickname, :site, :company, :residence, :profile, :twitter, :facebook, :birthday)
  end
end
