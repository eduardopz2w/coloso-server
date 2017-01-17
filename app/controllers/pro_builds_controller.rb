class ProBuildsController < ApplicationController
  def index
    @proBuilds = ProBuild.includes(:pro_summoner => :pro_player).paginate(:page => params[:page], :per_page => params[:per_page]).order('matchCreation DESC')
  end
end
