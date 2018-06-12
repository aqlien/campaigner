class ValidationCondition < ApplicationRecord
  include ActsAsResponse
  belongs_to :validation

  validates_presence_of :operator, :rule_key
  validates_inclusion_of :operator, in: SurveyTasks::OPERATORS
  validates_uniqueness_of :rule_key, scope: :validation_id

  def to_hash(response)
    {rule_key.to_sym => (response.nil? ? false : self.is_valid?(response))}
  end

  def is_valid?(response)
    klass = response.answer.response_class
    compare_to = Response.find_by_question_id_and_answer_id(self.question_id, self.answer_id) || self
    case self.operator
    when "==", "<", ">", "<=", ">="
      response.as(klass).send(self.operator, compare_to.as(klass))
    when "!="
      !(response.as(klass) == compare_to.as(klass))
    when "=~"
      return false if compare_to != self
      !(response.as(klass).to_s =~ Regexp.new(self.regexp || "")).nil?
    else
      false
    end
  end
end
