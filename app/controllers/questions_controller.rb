class QuestionsController < ApplicationController
   include QuestionsHelper

  def generate
    p params
    render json: {instructions: instructions(params), questions: generate_questions(params)}.as_json
  end

end
