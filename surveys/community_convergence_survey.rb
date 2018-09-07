# encoding: UTF-8
survey "Community Convergence", default_mandatory: false do
  # Event
  # name: "Community Convergence"
  # start_date: 2017/05/19

  section "Main Info" do

    q_1 "Are you a Community Convergence Chair?", short_text: "CC Chair", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_2 "Are you a Community Convergence Speaker?", short_text: "CC Speaker", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_3 "Are you a Community Convergence Organization Representative?", short_text: "CC org rep", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_4 "Are you part of the Community Convergence volunteer pool?", short_text: "CC volunteer", pick: :one
    a_1 "Yes"
    a_2 "No"
  end
end
