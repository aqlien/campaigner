require 'csv'

class DataImporter
  attr_accessor :filepath, :survey, :split_character

  def initialize(survey_id, filepath, options = {})
    @survey = Survey.find(survey_id)
    @filepath = [Rails.root, filepath].join('/')
  end

  def read_survey_data
    counter = 0
    CSV.foreach(@filepath, { headers: true }) do |csv_row|
      counter += 1
      puts  "Processing row #{counter}" if counter % 100 == 0

      user = User.find_or_create_by(email: csv_row['user_email']) do
        #do stuff here
      end

      s = @survey
      response_set = ResponseSet.find_or_create_by(user: user, survey: s)

      s.sections.each do |section|
        section.questions.each do |question|
          text = csv_row["q_#{question.id}"]
          unless text.blank?
            response_attrs = {question_id: question.id}
            pick_type = question.pick
            case pick_type
            when 'one', 'none'
              answer = question.answers.where(text: text).take
              answer ||= question.answers.take

              answer_text = answer.text

              case answer_text
              when /String/i
                response_attrs.merge!({string_value: text})
              when /Text/i
                response_attrs.merge!({text_value: text})
              end

              response_set.responses.create(response_attrs.merge({answer_id: answer.id}))
            when 'any'
              text_array = text.split(split_character)
              answer_ids = question.answers.where(text: text_array).pluck(:id)

              answer_ids.each do |answer_id|
                response_set.responses.create(response_attrs.merge({answer_id: answer_id}))
              end
            end
          end
        end
      end
    end
  end

  def split_character
    @split_character || '/'
  end

end
