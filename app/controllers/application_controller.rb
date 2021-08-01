class ApplicationController < ActionController::Base
    before_action :set_locale 

    protect_from_forgery with: :exception

    before_action :authenticate_user!

    def moon
    cookies[:moon] = {
        value: 'dark mode on'
    }
    if user_signed_in?
        redirect_to ''
    else
        redirect_to ''
    end
    end

    def sun
    cookies.delete(:moon)
    if user_signed_in?
        redirect_to ''
    else
        redirect_to ''
    end
    end
    

    def after_sign_in_path_for(resource)
       root_path
    end

    private

    def default_url_options
        {locale: I18n.locale}
    end

    def set_locale
        I18n.locale = extract_locale || I18n.default_locale
    end

    def extract_locale
        parsed_locale = params[:locale]
        I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
        parsed_locale.to_sym :
        nil
    end

end
