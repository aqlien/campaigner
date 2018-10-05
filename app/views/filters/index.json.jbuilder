presenter_options = UserFilterSetPresenter.new(@users, nil).options
user = UserFilterSetRecordPresenter.new(@users.first, nil, presenter_options)
filters = @filters || {}

keys = []
# Base Tab
keys << "id"
keys << "name"
keys << "email"
# Overview Tab
keys << "phone"
## Surveys Tab
# keys <<
# Interests Tab
keys << "interests"
# Tags Tab
keys << "tags"

collection_array = @users.collect do |user_record|
  user.__setobj__(user_record)
  a = []
  # Base Tab
  a << user.id
  a << user.name
  a << user.email
  # Overview Tab
  a << user.phone
  ## Surveys Tab
  # - @surveys.each do |survey|
  #   - survey.sections.each do |section|
  #     - section.questions.each do |question|
  #       - response_set = @response_sets.detect{|rs| rs.user_id == user.id && rs.survey_id == survey.id}
  #       - if response_set.present? && response_set.responses.present?
  #         a << display_answer_text(question, response_set)
  #       - else
  #         a << ""

  # Interests Tab
  a << user.interests
  # Tags Tab
  a << user.tags
  a
end

data = {"data" => collection_array.map!{|x| Hash[keys.zip(x)]}}

return data.to_json