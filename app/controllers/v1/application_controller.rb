module V1
  class ApplicationController < ActionController::Base
    before_action :setLocale

    def setLocale
      requestLocale = request.headers['Accept-Language']

      if requestLocale == 'es' || requestLocale == 'en'
        I18n.locale = requestLocale
      end
    end
  end
end
