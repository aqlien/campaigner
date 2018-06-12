class QuestionGroup < ApplicationRecord
  include MustacheContext
  has_many :questions
  has_one :dependency

  def initialize(*args)
    super(*args)
    default_args
  end

  def default_args
    self.display_type ||= "inline"
    self.api_id ||= SurveyTasks.generate_api_id
  end

  def renderer
    display_type.blank? ? :default : display_type.to_sym
  end

  def display_type=(val)
    write_attribute(:display_type, val.nil? ? nil : val.to_s)
  end

  def dependent?
    self.dependency != nil
  end

  def triggered?(response_set)
    dependent? ? self.dependency.is_met?(response_set) : true
  end

  def css_class(response_set)
    [(dependent? ? "g_dependent" : nil), (triggered?(response_set) ? nil : "g_hidden"), custom_class].compact.join(" ")
  end

  def text_for(context = nil, locale = nil)
    return "" if display_type == "hidden_label"
    in_context(translation(locale)[:text], context)
  end

  def help_text_for(context = nil, locale = nil)
    in_context(translation(locale)[:help_text], context)
  end

  def translation(locale)
    {:text => self.text, :help_text => self.help_text}.with_indifferent_access.merge(
      (self.questions.first.survey_section.survey.translation(locale)[:question_groups] || {})[self.reference_identifier] || {}
    )
  end

end
