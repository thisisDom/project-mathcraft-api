class LevelsController < ApplicationController

  def index
    render json: { levels: Level.order(:position) }
  end

end
