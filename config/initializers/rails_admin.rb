RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    authenticate_or_request_with_http_basic('Welcome to Hell') do |username, password|
      username == 'admin' && password == ENV['COLOSO_ADMIN_PASSWORD']
    end
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'ProSummoner' do
    object_label_method do
      :summonerId
    end

    list do
      include_all_fields
      field :lastCheck do
        pretty_value do
          daysDiff = (DateTime.now - Time.at(value / 1000).to_datetime)
          hoursDiff = daysDiff * 24
          minDiff = hoursDiff * 60


          if daysDiff >= 1
            "Hace #{daysDiff.to_i} dias"
          elsif hoursDiff >= 1
            "Hace #{hoursDiff.to_i} horas"
          else
            "Hace #{minDiff.to_i} minutos"
          end
        end
      end
    end
  end
end
