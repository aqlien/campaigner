module FiltersHelper
  def display_answer_text(question, response_set)
    pick_type = question.pick
    case pick_type
    when 'one', 'none'
      response = response_set.responses.where(question_id: question.id).take
      text = response.answer.text if response
      case text
      when /String/i
        response.string_value
      when /Text/i
        response.text_value
      else
        text
      end
    when 'any'
      response_set.responses.joins(:answer).where(question_id: question.id).pluck('answers.text').join('/')
    end
  end

  def datatables_searchable_class(survey_question)
    pick_type = survey_question.pick
    case pick_type
    when 'one'
      'select_searchable'
    when 'any'
      'text_searchable'
      # 'multi_select_searchable'
    when 'none'
      'text_searchable'
    end
  end

end
