# encoding: UTF-8
survey "Call for Volunteers", default_mandatory: true do
  section "Main Info" do
    # Event ID (hard-coded)

    # User Info
    q_1 "Full Name", is_mandatory: false
    answer :string

    q_2 "What would you like us to call you? (i.e. a nickname, just your first name, etc.)", is_mandatory: false
    answer :string

    q_3 "Preferred Pronouns", pick: :one, is_mandatory: false
    a_1 "she/her"
    a_2 "he/him"
    a_3 "they/them"
    a_4 :other

    q_4 "Email"
    answer :string

    q_5 "Password"
    answer :string
  end

  section "Volunteer questions" do
    q_6 "Are you interested in volunteering just for the march/rally?", pick: :one, is_mandatory: false, display_type: :inline
    a_1 "Yes"
    a_2 "No", help_text: " I want to help with the events."

    q_7 "Phone Number"
    answer :string, input_mask: '(999)999-9999', input_mask_placeholder: '#'

    q_8 "Best time to be contacted", pick: :any
    a_1 "Morning"
    a_2 "Afternoon"
    a_3 "Evening"
    a_4 "Weekend"

    q_9 "What are you interested in volunteering for?", pick: :any
    a_1 "Organizing volunteers"
    a_2 "Social Media Support"
    a_3 "Procurement"
    a_4 "Art/Signage"
    a_5 "Day-of support only"

    q_10 "Additional relevant information you want to share (special skills, unique connections, etc.)", is_mandatory: false
    answer :text
  end
end
