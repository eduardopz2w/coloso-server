class StatusController < ApplicationController
  skip_before_action :checkVersion

  def android_app
    return render(json: {
      :data => {
        :apkVersions => {
          actual: '1.0.4',
          min: '1.0.3',
        },
      },
    })
  end
end
