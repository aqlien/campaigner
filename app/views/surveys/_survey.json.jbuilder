json.extract! survey, :id, :type, :user_id, :event_id, :created_at, :updated_at
json.url survey_url(survey, format: :json)
