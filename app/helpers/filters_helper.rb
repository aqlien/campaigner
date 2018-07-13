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

end
