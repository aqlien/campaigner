module UsersHelper

  def pronouns_for_select
    # Note that if you change the wording for 'Other', you'll need to update the users.js.coffee javascript
    [ ['She/Her', 'she/her'], ['He/Him', 'he/him'], ['They/Them', 'they/them'], ['Other', ''] ]
  end

  def display_pronouns(user)
    (user.pronoun || '').split('/').collect{|p| p.titlecase }.join('/')
  end

end
