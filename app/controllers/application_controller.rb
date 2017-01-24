class ApplicationController < ActionController::API
  before_action :setLocale

  def setLocale
    locale = request.headers['Accept-Language']

    if locale == 'en' || locale == 'es'
      I18n.locale = locale
    else
      I18n.locale = 'es'
    end
  end
end
