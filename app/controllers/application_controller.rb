class ApplicationController < ActionController::Base
  before_action :setLocale

  def setLocale
    locales = ['en', 'es', 'pt']
    requestLocale = request.headers['Accept-Language']

    if locales.include?(requestLocale)
      I18n.locale = requestLocale
    end
  end
end
