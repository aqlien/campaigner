module FiltersHelper
  def answer_text(answer, response)
    text = answer.text
    case text
    when /String/i
      response.string_value
    when /Text/i
      response.text_value
    else
      text
    end
  end

  def datatables_searchable_class(survey_question)
    pick_type = survey_question.pick
    case pick_type
    when 'one'
      'select_searchable'
    when 'any'
      'multi_select_searchable'
    when 'none'
      'text_searchable'
    end
  end

end
