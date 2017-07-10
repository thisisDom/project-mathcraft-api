class QuestionsController < ApplicationController
  include QuestionsHelper
  include TensHelper

  def generate
    render json: {instructions: instructions(params), questions: generate_questions(params)}.to_json
  end
  
end
