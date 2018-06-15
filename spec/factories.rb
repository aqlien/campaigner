require 'factory_girl'

FactoryGirl.define do
  sequence(:unique_survey_access_code){|n| "simple survey #{UUIDTools::UUID.random_create.to_s}" }

  factory :event, class: Event do
    name            "March for Justice"
    start_date      Date.today
    end_date        Date.today
  end

  factory :user, class: User do
    name            "User McUserson"
    short_name      "User"
    pronoun         "Ms."
    email           { |ue| "user#{ue.object_id}@test.com" }
    admin           false
    active          true
    # organization_id nil
  end

  factory :survey, class: Survey do
    association     :event
    title           "Simple survey"
    description     "A simple survey for testing"
    access_code     { FactoryGirl.generate :unique_survey_access_code }
    survey_version  0
  end

  factory :survey_translation, class: SurveyTranslation do
    association :survey
    locale "es"
    translation %(title: "Un idioma nunca es suficiente"
                  survey_sections:
                    one:
                      title: "Uno"
                  questions:
                    hello:
                      text: "¡Hola!"
                    name:
                      text: "¿Cómo se llama Usted?"
                      answers:
                        name:
                          help_text: "Mi nombre es...")
  end

  sequence(:survey_section_display_order){|n| n }

  factory :survey_section, class: SurveySection do
    association               :survey # s.survey_id                 {}
    title                     {"Demographics"}
    description               {"Asking you about your personal data"}
    display_order             {FactoryGirl.generate :survey_section_display_order}
    reference_identifier      {"demographics"}
    data_export_identifier    {"demographics"}
  end

  sequence(:question_display_order){|n| n }

  factory :question, class: Question do
    association             :survey_section  # s.survey_section_id       {}
    # question_group_id       {}
    text                    "What is your favorite color?"
    short_text              "favorite_color"
    help_text               "just write it in the box"
    pick                    :none
    reference_identifier    {|me| "q_#{me.object_id}"}
    # data_export_identifier  {}
    # common_namespace        {}
    # common_identifier       {}
    display_order           FactoryGirl.generate(:question_display_order)
    # display_type            {} # nil is default
    is_mandatory            false
    # display_width           {}
    correct_answer_id       nil
  end

  factory :question_group, class: QuestionGroup do
    text                    {"Describe your family"}
    # help_text               {}
    reference_identifier    {|me| "g_#{me.object_id}"}
    # data_export_identifier  {}
    # common_namespace        {}
    # common_identifier       {}
    # display_type            {}
    # custom_class            {}
    # custom_renderer         {}
  end

  sequence(:answer_display_order){|n| n }

  factory :answer, class: Answer do
    association               :question  # a.question_id               {}
    text                      "My favorite color is clear"
    short_text                "clear"
    help_text                 "Clear is the absense of color"
    # weight
    response_class            "string"
    # reference_identifier      {}
    # data_export_identifier    {}
    # common_namespace          {}
    # common_identifier         {}
    display_order             {FactoryGirl.generate :answer_display_order}
    # is_exclusive              {}
    display_type              "default"
    # display_length            {}
    # custom_class              {}
    # custom_renderer           {}
  end

  factory :dependency, class: Dependency do
    # the dependent question
    association       :question # d.question_id       {}
    # question_group_id {}
    rule              {"A"}
  end

  factory :dependency_condition, class: DependencyCondition do
    association       :dependency # d.dependency_id    {}
    rule_key          {"A"}
    # the conditional question
    association       :question # d.question_id       {}
    operator          {"=="}
    association       :answer   # d.answer_id         {}
    datetime_value    {}
    integer_value     {}
    float_value       {}
    unit              {}
    text_value        {}
    string_value      {}
    response_other    {}
  end

  factory :response_set, class: ResponseSet do
    association :survey
    association :user

    access_code     {SurveyTasks.make_tiny_code}
    started_at      {Time.now}
    completed_at    {}
  end

  factory :response, class: Response do
    association :response_set
    association :answer

    question          { answer.question }
    # survey_section_id {}
    datetime_value    {}
    integer_value     {}
    float_value       {}
    unit              {}
    text_value        {}
    string_value      {}
    response_other    {}
    response_group    {}
  end

  factory :validation, class: Validation do
    association       :answer # v.answer_id         {}
    rule              {"A"}
    message           {}
  end

  factory :validation_condition, class: ValidationCondition do
    association       :validation # v.validation_id     {}
    rule_key          {"A"}
    question_id       {}
    operator          {"=="}
    answer_id         {}
    datetime_value    {}
    integer_value     {}
    float_value       {}
    unit              {}
    text_value        {}
    string_value      {}
    response_other    {}
    regexp            {}
  end
end
