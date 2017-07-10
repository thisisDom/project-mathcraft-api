class QuestionsController < ApplicationController
  include QuestionsHelper
  def generate
    render json: {questions: generate_questions(params)}.to_json
  end
end
