class Question < ApplicationRecord
  include MustacheContext
  belongs_to :survey_section
  belongs_to :question_group, dependent: :destroy, optional: true
  has_many :answers, dependent: :destroy # it might not always have answers
  has_one :dependency, dependent: :destroy
  belongs_to :correct_answer, class_name: "Answer", dependent: :destroy, optional: true

  validates_presence_of :text, :display_order
  validates_inclusion_of :is_mandatory, in: [true, false]

  def initialize(*args)
    super(*args)
    default_args
  end

  def default_args
    self.is_mandatory ||= false
    self.display_type ||= "default"
    self.pick ||= "none"
    self.data_export_identifier ||= SurveyTasks.normalize_string(text)
    self.short_text ||= text
    self.api_id ||= SurveyTasks.generate_api_id
  end

  def pick=(val)
    write_attribute(:pick, val.nil? ? nil : val.to_s)
  end

  def display_type=(val)
    write_attribute(:display_type, val.nil? ? nil : val.to_s)
  end

  def mandatory?
    self.is_mandatory == true
  end

  def dependent?
    self.dependency != nil
  end

  def triggered?(response_set)
    dependent? ? self.dependency.is_met?(response_set) : true
  end

  def css_class(response_set)
    [(dependent? ? "q_dependent" : nil), (triggered?(response_set) ? nil : "q_hidden"), custom_class].compact.join(" ")
  end

  def part_of_group?
    !self.question_group.nil?
  end

  def solo?
    self.question_group.nil?
  end

  def text_for(position = nil, context = nil, locale = nil)
    return "" if display_type == "hidden_label"
    imaged(split(in_context(translation(locale)[:text], context), position))
  end

  def help_text_for(context = nil, locale = nil)
    in_context(translation(locale)[:help_text], context)
  end

  def split(text, position=nil)
    case position
    when :pre
      text.split("|",2)[0]
    when :post
      text.split("|",2)[1]
    else
      text
    end.to_s
  end

  def renderer(g = question_group)
    r = [g ? g.renderer.to_s : nil, display_type].compact.join("_")
    r.blank? ? :default : r.to_sym
  end

  def translation(locale)
    {:text => self.text, :help_text => self.help_text}.with_indifferent_access.merge(
      (self.survey_section.survey.translation(locale)[:questions] || {})[self.reference_identifier] || {}
    )
  end

  private

  def imaged(text)
    self.display_type == "image" && text.present? ? ActionController::Base.helpers.image_tag(text) : text
  end
end
