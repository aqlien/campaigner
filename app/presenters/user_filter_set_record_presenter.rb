class UserFilterSetRecordPresenter < BasePresenter
  delegate :fa_icon, :link_to, :policy, to: :@template, allow_nil: true
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

  #actions
  def show_link
    if policy(:user).show?
      link_to(user_path(record['id']), {title: 'Show', class: 'icon'}){fa_icon('eye')}
    end
  end

  def edit_link
    if policy(:user).edit?
      link_to(edit_user_path(record['id']), {title: 'Edit', class: 'icon'}){fa_icon('wrench')}
    end
  end

  def destroy_link
    if policy(:user).destroy?
      link_to(user_path(record['id']), {method: :delete, data: { confirm: 'Are you sure?' }, title: 'Destroy', class: 'icon'}){fa_icon('times')}
    end
  end

  def link_set
    [show_link, edit_link, destroy_link].compact.join('')
  end

end
