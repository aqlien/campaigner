require 'csv'

class DataImporter
  attr_accessor :filepath, :survey, :split_character

  def initialize(survey_id, filepath, options = {})
    @survey = Survey.find(survey_id) unless (survey_id == 0 || survey_id == nil)
    @filepath = [Rails.root, filepath].join('/')
    @split_character = options[:split_character] if options[:split_character]
  end

  def save
    read_survey_data
  end

  def read_survey_data
    counter = 0
    CSV.foreach(@filepath, { headers: true }) do |csv_row|
      counter += 1
      puts  "Processing row #{counter}" if counter % 100 == 0

      user = parse_user_row(csv_row)

      if @survey
        parse_survey_row(csv_row, user)
      end
    end
  end

  def parse_user_row(csv_row)
    User.find_or_create_by(email: csv_row['user_email']) do |u|
      u.name = csv_row['name'] || csv_row['full_name']
      u.short_name = csv_row['short_name'] || csv_row['first_name']
      u.pronoun = csv_row['pronoun'].try(:downcase)
      u.phone = csv_row['phone']
      u.city = csv_row['city']

      if csv_row['organization']
        u.organization_id = org_list[csv_row['organization']]
      end

      interest_ids = []
      interest_headers(csv_row).each do |interest_heading|
        if csv_row[interest_heading] == 'yes'
          interest_text = interest_heading.match(/^interest_(.*)/)[1]
          interest_id = interest_list[interest_text]
          interest_ids << interest_id if interest_id
        end
      end
      u.interest_ids = interest_ids

      tag_ids = []
      tag_headers(csv_row).each do |tag_heading|
        if csv_row[tag_heading] == 'yes'
          tag_text = tag_heading.match(/^tag_(.*)/)[1]
          tag_id = tag_list[tag_text]
          tag_ids << tag_id if tag_id
        end
      end
      u.tag_ids = tag_ids

      u.notes = csv_row['notes']
    end
  end

  def parse_survey_row(csv_row, user)
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

  def org_list
    @org_list ||= Organization.all.pluck(:name, :id).to_h
  end

  def interest_list
    @interest_list ||= Interest.all.collect{|i| [i.short_text, i.id]}.to_h
  end

  def tag_list
    @tag_list ||= Tag.all.collect{|t| [t.short_text, t.id]}.to_h
  end

  def split_character
    @split_character || '/'
  end

  def csv_headers(csv_row)
    @csv_headers ||= csv_row.headers
  end

  def interest_headers(csv_row)
    @interest_headers ||= csv_headers(csv_row).select{|h| h.match(/^interest_/)}
  end

  def tag_headers(csv_row)
    @tag_headers ||= csv_headers(csv_row).select{|h| h.match(/^tag_/)}
  end

end
