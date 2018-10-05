# encoding: UTF-8
survey "2019 Anniversary Survey", default_mandatory: false do
  # Event
  # name: "Women Connext Seattle"
  # start_date: 2019/01/19

  section "Training Dates" do

    q_1 "Please select the volunteer opportunities that interest you", pick: :any, is_mandatory: true
    a_1 "March/rally peacekeeper (please see next question)"
    a_2 "Communications/social media"
    a_3 "Event planning"
    a_4 "Art/signage/graphic design"
    a_5 "Day-of volunteer (check in, set up/tear down, etc.)"
    a_6 "Procurement"

    q_2 "If you're interested in volunteering as a Peacekeeper at the march/rally, which mandatory training will you attend?", pick: :one
    dependency :rule => "A"
    condition_A :q_1, "==", :a_1
    a_1 "November 13, 7-8:30 pm"
    a_2 "December 1, 10-11:30 am"

    q_3 "Additional information and/or comments"
    a_1 :text

  end
end
