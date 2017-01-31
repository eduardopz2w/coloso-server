require 'semantic'

class ApplicationController < ActionController::API
  before_action :setLocale
  before_action :checkVersion

  def setLocale
    locale = request.headers['Accept-Language']

    if locale == 'en' || locale == 'es'
      I18n.locale = locale
    else
      I18n.locale = 'es'
    end
  end

  def checkVersion
    minVersion = '1.0.3'
    requestVersion = request.headers['App-Version']

    begin
      requestVersion = Semantic::Version.new(requestVersion)
      minVersion = Semantic::Version.new(minVersion)

      if requestVersion < minVersion
        return render(json: { :message => I18n.t('update_required') }, status: 400)
      end
    rescue
      return render(json: { :message => I18n.t('update_required') }, status: 400)
    end
  end
end
