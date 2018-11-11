class SurveySection < ApplicationRecord
  has_many :questions, ->{ order(display_order: :asc) }, dependent: :destroy
  belongs_to :survey

  validates_presence_of :title, :display_order

  def initialize(*args)
    super(*args)
    default_args
  end

  def default_args
    self.data_export_identifier ||= SurveyTasks.normalize_string(title)
  end

  def questions_and_groups
    questions.each_with_index.map do |q,i|
      if q.part_of_group?
        if (i+1 >= questions.size) or (q.question_group_id != questions[i+1].question_group_id)
          q.question_group
        end
      else
        q
      end
    end.compact
  end

  def translation(locale)
    {:title => self.title, :description => self.description}.with_indifferent_access.merge(
      (self.survey.translation(locale)[:survey_sections] || {})[self.reference_identifier] || {}
    )
  end
end
