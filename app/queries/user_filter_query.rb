require 'pg'
class UserFilterQuery

  def initialize(options = {})
    @filters = options[:filters] || {active: true}
  end

  def results
    @results ||= combined_data
  end

private
  def base_user_ids_query
    <<-SQL
      WITH user_ids AS (
        SELECT users.id
        FROM users
        WHERE users.admin IS NOT TRUE
    SQL
  end

  def filtered_user_ids_query
    sql = base_user_ids_query
    sql << filter_active if @filters[:active]
    sql << filter_contactable if @filters[:contactable]
    sql << filter_not_in_organization if @filters[:no_org]
    sql << ')'
  end

  def user_ids
    User.find_by_sql(filtered_user_ids_query + 'SELECT id FROM user_ids').collect{|x| x['id']}
  end

  def combined_data
    all_data = []
    overview_data.keys.each_with_index do |user_id, index|
      all_data[index] = {}
      all_data[index].merge!(overview_data[user_id] || {})
      all_data[index].merge!(survey_data[user_id] || {})
      all_data[index].merge!(interest_data[user_id] || {})
      all_data[index].merge!(tag_data[user_id] || {})
    end
    all_data
  end

  def overview_data
    @overview_data ||= Hash[User.find_by_sql(overview_query).collect{|x| x.attributes}.collect{|x| [x['id'], x]}]
  end

  def survey_data
    @survey_data ||= Hash[User.find_by_sql(survey_query).collect{|x| x.attributes}.collect{|x| x['answer_data'] = x['question_ids'].zip(x['answer_ids'].zip(x['answer_text'])); h = {}; x['survey_ids'].zip(x['answer_data']).group_by{|x| x[0]}.each{|k,v| h[k] = v.collect{|x| x[1,x.length]}.flatten(1)}; x['survey_data'] = h; x['survey_dates'] = x['survey_ids'].zip(x['survey_completion_dates']).to_h; x.delete('answer_text'); x.delete('answer_ids'); x.delete('question_ids'); x.delete('survey_ids'); x.delete('answer_data'); x.delete('survey_completion_dates'); x}.collect{|x| [x['user_id'], x]}]
  end

  def interest_data
    @interest_data ||= Hash[User.find_by_sql(interest_query).collect{|x| x.attributes}.collect{|x| [x['user_id'], x]}]
  end

  def tag_data
    @tag_data ||= Hash[User.find_by_sql(tag_query).collect{|x| x.attributes}.collect{|x| [x['user_id'], x]}]
  end

  def overview_query
    filtered_user_ids_query +
    <<-SQL
      SELECT users.*
      FROM users
      WHERE users.id IN (select id from user_ids)
      GROUP BY users.id
    SQL
  end

  def survey_query
    filtered_user_ids_query +
    <<-SQL
      SELECT response_sets.user_id,
      array_agg(response_sets.survey_id) AS survey_ids,
      array_agg(response_sets.completed_at) AS survey_completion_dates,
      array_agg(responses.id) AS response_ids,
      array_agg(responses.question_id) AS question_ids,
      array_agg(responses.answer_id) AS answer_ids,
      array_agg(CASE WHEN answers.short_text ISNULL THEN answers.text ELSE answers.short_text END) AS answer_text
      FROM response_sets
      JOIN responses ON responses.response_set_id = response_sets.id
      JOIN answers ON responses.answer_id = answers.id
      WHERE response_sets.user_id IN (select id from user_ids)
      GROUP BY response_sets.user_id
    SQL
  end

  def interest_query
    filtered_user_ids_query +
    <<-SQL
      SELECT interests_users.user_id as id, interests_users.user_id,
        array_agg(DISTINCT interests.text) interest_names
      FROM interests_users
      INNER JOIN interests ON interests.id = interests_users.interest_id
      WHERE interests_users.user_id IN (select id from user_ids)
      GROUP BY interests_users.user_id
    SQL
  end

  def tag_query
    filtered_user_ids_query +
    <<-SQL
      SELECT tags_users.user_id as id, tags_users.user_id,
        array_agg(DISTINCT tags.text) tag_names
      FROM tags_users
      INNER JOIN tags ON tags.id = tags_users.tag_id
      WHERE tags_users.user_id IN (select id from user_ids)
      GROUP BY tags_users.user_id
    SQL
  end

  def filter_active
    <<-SQL
      AND users.active = true
    SQL
  end

  def filter_contactable
    # we want users with email and phone, email is already requred so no need to check
    <<-SQL
      AND users.phone <> ''
    SQL
  end

  def filter_not_in_organization
    <<-SQL
      AND users.organization_id IS NULL
    SQL
  end

end
