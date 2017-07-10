class LevelsController < ApplicationController

  def index
    levels = Level.order(:position).pluck(:id).map { |level|
      level.as_json
    }
    render json: { levels: levels.as_json }
  end

end
