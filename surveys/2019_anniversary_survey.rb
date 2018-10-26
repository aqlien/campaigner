# encoding: UTF-8
survey "2019 Anniversary Survey", default_mandatory: false do
  # Event
  # name: "Women Connext Seattle"
  # start_date: 2019/01/19

  section "Training Dates" do

    q_1 "Please select the volunteer opportunities that interest you", short_text: 'Volunteer type', pick: :any, is_mandatory: true
    a_1 "March/rally peacekeeper (Top Priority!) (Training is required for peacekeepers)", short_text: 'peacekeeper'
    a_2 "Communications/social media", short_text: 'comms'
    # a_3 "Event planning", short_text: 'plans'
    a_4 "Art/signage/graphic design", short_text: 'art'
    a_5 "Day-of volunteer (check in, set up/tear down, etc.)", short_text: 'day-of'
    a_6 "Procurement (Top Priority!)"
    a_7 "Fundraising (Top Priority!)"

    q_2 "If you're interested in volunteering as a Peacekeeper at the march/rally, which mandatory training will you attend?", pick: :one, is_mandatory: true
    dependency :rule => "A"
    condition_A :q_1, "==", :a_1
    a_1 "November 13, 7-8:30 pm"
    a_2 "December 1, 10-11:30 am"
    a_3 "January date TBD (You will be emailed with date once it is available.)"
    label "Two additional training dates will be available in January. Specific dates and times are yet to be determined."
    dependency :rule => "A"
    condition_A :q_1, "==", :a_1

    q_4 "Do you speak any of the following languages?", pick: :any
    a_1 "ASL"
    a_2 "Amharic"
    a_3 "Arabic"
    a_4 "Farsi"
    a_5 "Filipino"
    a_6 "French"
    a_7 "German"
    a_8 "Hebrew"
    a_9 "Hindi"
    a_10 "Japanese"
    a_11 "Mandarin"
    a_12 "Portuguese"
    a_13 "Russian"
    a_14 "Spanish"
    a_15 "Turkish"
    a_16 "Ukrainian"
    a_17 "Urdu"
    a_18 "Vietnamese"

    q_3 "Additional information and/or comments"
    a_1 :text

  end
end
