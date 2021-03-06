class Dependency < ApplicationRecord
  belongs_to :question, optional: true
  belongs_to :question_group, optional: true
  has_many :dependency_conditions, dependent: :destroy

  validates_presence_of :rule
  validates_format_of :rule, with: /\A(?<cond>((\s*!?[A-Z]+\s*)|(\s*!?\(\g<cond>\)\s*))(\s(and|or)\s\g<cond>)?)\Z/
  validates_numericality_of :question_id, if: Proc.new { |d| d.question_group_id.nil? }
  validates_numericality_of :question_group_id, if: Proc.new { |d| d.question_id.nil? }

  alias_attribute :dependent_question_id, :question_id

  def question_group_id=(i)
    write_attribute(:question_id, nil) unless i.nil?
    write_attribute(:question_group_id, i)
  end

  def question_id=(i)
    write_attribute(:question_group_id, nil) unless i.nil?
    write_attribute(:question_id, i)
  end

  # Has this dependency has been met in the context of response_set?
  # Substitutes the conditions hash into the rule and evaluates it
  def is_met?(response_set)
    ch = conditions_hash(response_set)
    return false if ch.blank?
    # logger.debug "rule: #{self.rule.inspect}"
    # logger.debug "rexp: #{rgx.inspect}"
    # logger.debug "keyp: #{ch.inspect}"
    # logger.debug "subd: #{self.rule.gsub(rgx){|m| ch[m.to_sym]}}"
    rgx = Regexp.new(self.dependency_conditions.map{|dc| ["a","o"].include?(dc.rule_key) ? "\\b#{dc.rule_key}(?!nd|r)\\b" : "\\b#{dc.rule_key}\\b"}.join("|")) # exclude and, or

    eval(self.rule.gsub(rgx){|m| ch[m.to_sym]})
  end

  # A hash of the conditions (keyed by rule_key) and their evaluation (boolean) in the context of response_set
  def conditions_hash(response_set)
    hash = {}
    self.dependency_conditions.each{ |dc| hash.merge!(dc.to_hash(response_set)) }
    return hash
  end
end
