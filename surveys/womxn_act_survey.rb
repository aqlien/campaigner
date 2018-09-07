# encoding: UTF-8
survey "Womxn Act on Seattle", default_mandatory: false do
  # Event
  # name: "Womxn Act on Seattle"
  # start_date: 2018/01/21

  section "Main Info" do

    q_1 "Are you a Womxn Act Chair?", short_text: "ACT Chair", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_2 "Are you a Womxn Act Speaker?", short_text: "ACT Speaker", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_3 "Are you a Womxn Act Organization Representative?", short_text: "ACT org rep", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_4 "Are you a Womxn Act volunteer lead?", short_text: "ACT volunteer lead", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_5 "Are you part of the Womxn Act volunteer pool?", short_text: "ACT volunteer", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_6 "Are you a Womxn Act Hub leader?", short_text: "ACT Hub leader", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_7 "Are you a Womxn Act Hub location?", short_text: "ACT Hub location", pick: :one
    a_1 "Yes"
    a_2 "No"
  end
end
