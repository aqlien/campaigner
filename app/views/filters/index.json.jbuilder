presenter_options = UserFilterSetPresenter.new(@users, self, {participation_rules: ParticipationRules.new}).options
user = UserFilterSetRecordPresenter.new(@users.first, self, presenter_options)
filters = @filters || {}

keys = []
# Base Tab
keys << "id"
keys << "name"
keys << "email"
# Overview Tab
keys << "phone"
keys << "city"
keys << "signup"
# Organization Tab
keys << "organization"
# Surveys Tab
@surveys.each do |survey|
  keys << "responded_#{survey.id}"
  survey.sections.each do |section|
    section.questions.each do |question|
      keys << "q_#{question.id}"
    end
  end
end
# Outreach Tab
keys << "admin_notes"
# Interests Tab
keys << "interests"
# Outreach Tab (II)
keys << "event_names"
# Tags Tab
keys << "tags"
keys << "actions"

collection_array = @users.collect do |user_record|
  user.__setobj__(user_record)
  a = []
  # Base Tab
  a << user.id
  a << user.name
  a << user.email
  # Overview Tab
  a << user.phone
  a << user.city
  a << user.signup
  #Organization Tab
  a << user.organization
  ## Surveys Tab
  @surveys.each do |survey|
    a << user.response_date(survey.id)
    survey.sections.each do |section|
      section.questions.each do |question|
        a << user.answer(question)
      end
    end
  end
  # Outreach Tab
  a << user.admin_notes
  # Interests Tab
  a << user.interests
  # Outreach Tab (II)
  a << user.event_names
  # Tags Tab
  a << user.tags
  # actions
  a << user.link_set
  a
end

data = {"data" => collection_array.map!{|x| Hash[keys.zip(x)]}}

return data.to_json
