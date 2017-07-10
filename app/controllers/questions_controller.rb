class QuestionsController < ApplicationController
  include QuestionsHelper
  def generate
    render json: {questions: make_20_questions(params)}.to_json
  end
end
