class UserFilterSetRecordPresenter < BasePresenter
  delegate :fa_icon, :link_to, :policy, to: :@template, allow_nil: true
  presents :record

  #User
  def id
    record['id'] || record['user_id']
  end

  def name
    record['name'] || record['short_name']
  end

  def email
    record['email']
  end

  def last_name
    record['last_name']
  end

  #Overview
  def phone
    record['phone']
  end

  def city
    record['city']
  end

  def signup
    record['created_at'].to_date.strftime("%Y/%m/%d")
  end

  def notes
    record['notes']
  end

  #Organization
  def organization
    record['organization_id'].present? ? 'Y' : ''
  end

  # Surveys
  def responded?(survey_id)
    response_boolean = record['survey_data'].present? && record['survey_data'].keys.include?(survey_id)
    response_boolean ? 'Y' : ''
  end

  def response_date(survey_id)
    response_indicator = record['survey_dates'].present? && record['survey_dates'].keys.include?(survey_id)
    response_indicator = response_indicator ? record['survey_dates'][survey_id] : nil
    response_indicator ? response_indicator.to_date.strftime("%Y/%m/%d") : ''
  end

  def answer(question_object)
    question_id = question_object.id
    if record['survey_data']
      survey_id = question_object.survey_section.survey_id
      answer_data = record['survey_data'][survey_id]
      if answer_data
        answer_data.select{|k,v| k == question_id}.collect{|k,v| v[1]}.join(split_character)
      end
    end
  end

  def event_names
    participation_checker = @options[:participation_rules] || ParticipationRules.new
    if record['survey_data']
      participation_checker.check(record['survey_data']).join(split_character)
    end
  end

  # Outreach
  def admin_notes
    record['admin_notes']
  end

  # Interests
  def interests
    (record['interest_names'] || []).sort.join(split_character)
  end

  # Tags Tab
  def tags
    (record['tag_names'] || []).sort.join(split_character)
  end

  #actions
  def show_link
    if policy(:user).show?
      link_to(user_path(id), {title: 'Show', class: 'icon'}){fa_icon('eye')}
    end
  end

  def edit_link
    if policy(:user).edit?
      link_to(edit_user_path(id), {title: 'Edit', class: 'icon'}){fa_icon('wrench')}
    end
  end

  def destroy_link
    if policy(:user).destroy?
      link_to(user_path(id), {method: :delete, data: { confirm: 'Are you sure?' }, title: 'Destroy', class: 'icon'}){fa_icon('times')}
    end
  end

  def link_set
    [show_link, edit_link, destroy_link].compact.join('')
  end

  #filter info
  def split_character
    '; '
  end

end
