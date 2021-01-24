class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i(firstname lastname))
    end

    #タグ形成
    def tag_array(params)
        tag = params.strip.gsub(/[[:space:]]/, ',').split(",")
    end
end
