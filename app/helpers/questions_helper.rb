module QuestionsHelper
  def difficulty_setting(mode)
    case mode
    when "easy"
        return (1..9)
    when "medium"
        return (5..20)
    when "hard"
        return (10..30)
    end
  end

  def operation_setting(type)
    case type
    when "addition"
        return :+
    when "subtraction"
        return :-
    when "multiplication"
        return :*
    end
  end

  def first_num(range)
      return rand(range)
  end

  def second_num(range, first_num)
      return rand(range.first..first_num)
  end

  def answer(operation, first, second)
      return [first, second].reduce(operation)
  end

  def create_question(operation, difficulty)
      # logic for creating first
      first = first_num(difficulty)
      # logic for creating second
      second = second_num(difficulty,first)
      # logic for creating answer
      answer = answer(operation, first, second)
      # logic for creating problem
      problem = "#{first} #{operation} #{second}"

      return { problem: problem,
               answer: answer}

  end

  def generate_questions(params)
      operation = operation_setting(params[:type])
      difficulty_range = difficulty_setting(params[:difficulty])
      questions = []
      20.times do
          questions << create_question(operation, difficulty_range)
      end
      return questions
  end

  def instructions(params)
    type = params[:type]
    case type
    when "addition"
      return "Return the sum of the two numbers"
    when "subtraction"
      return "Subtract the second number from the first"
    when "multiplication"
      return "Return the product of the two numbers"
    end
  end

end
