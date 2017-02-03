class StatusController < ApplicationController
  skip_before_action :checkVersion

  def android_app
    return render(json: {
      :data => {
        :apkVersions => {
          actual: Rails.application.config.androidActualApkVersion,
          min: Rails.application.config.androidMinApkVersion,
        },
      },
    })
  end
end
