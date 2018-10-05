class UserFilterSetRecordPresenter < BasePresenter
  attr_accessor :list_ids
  presents :record

  #User
  def id
    record['id']
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

  #Organization
  def organization
    record['organization_id'].present? ? 'Y' : ''
  end

  # Surveys

  # Interests
  def interests
    (record['interest_names'] || []).sort.join(';')
  end

  # Tags Tab
  def tags
    (record['tag_names'] || []).sort.join(';')
  end
end
