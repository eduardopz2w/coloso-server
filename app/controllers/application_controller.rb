require 'semantic'

class ApplicationController < ActionController::API
  before_action :setLocale
  before_action :checkVersion

  def setLocale
    requestLocale = request.headers['Accept-Language']

    if requestLocale == 'en'
      I18n.locale = requestLocale
    end
  end

  def checkVersion
    requestVersion = request.headers['App-Version']

    begin
      requestVersion = Semantic::Version.new(requestVersion)
      minVersion = Semantic::Version.new(Rails.application.config.androidMinApkVersion)

      if requestVersion < minVersion
        return render(json: { :message => I18n.t('update_required') }, status: 400)
      end
    rescue
      return render(json: { :message => I18n.t('update_required') }, status: 400)
    end
  end
end
