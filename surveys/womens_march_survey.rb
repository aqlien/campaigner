# encoding: UTF-8
survey "Women's March", default_mandatory: false do
  # Event
  # name: "Women's March"
  # start_date: 2017/01/21

  section "Main Info" do

    q_1 "Are you a Women's March Chair?", short_text: "WMoS Chair", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_2 "Are you a Women's March Rally Speaker?", short_text: "WMoS Rally Speaker", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_3 "Are you a Women's March Soapbox Speaker?", short_text: "WMoS Soapbox Speaker", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_4 "Are you a Women's March Organization Representative?", short_text: "WMoS org rep", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_5 "Are you part of the Women's March volunteer pool?", short_text: "WMoS volunteer pool", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_6 "Are you a Women's March Connector?", short_text: "WMoS Connector", pick: :one
    a_1 "Yes"
    a_2 "No"

    q_7 "Are you a Women's March Peaceful Marcher?", short_text: "WMoS Peaceful Marcher", pick: :one
    a_1 "Yes"
    a_2 "No"
  end
end
