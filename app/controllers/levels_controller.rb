class LevelsController < ApplicationController

  def index
    render json: { levels: Level.order(:position).as_json }
  end


end
