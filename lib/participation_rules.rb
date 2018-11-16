class ParticipationRules

  def initialize
    @@rules = build_index
    @@event_order = get_event_order
  end

  def check(user_record_survey_data)
    events_participated_in = []
    user_record_survey_data.each do |survey_id, survey_answer_data|
      in_event = false
      user_answer_ids = survey_answer_data.collect{|question_id, answer_data| answer_data[0]}
      if @@rules[:events][@@rules[:surveys][survey_id][:event_name]][:conditions][:modifier] == 'any_of'
        in_event = (@@rules[:events][@@rules[:surveys][survey_id][:event_name]][:conditions][:answer_ids] & user_answer_ids).any?
      elsif @@rules[:events][@@rules[:surveys][survey_id][:event_name]][:conditions][:modifier] == 'all_of'
        in_event = @@rules[:events][@@rules[:surveys][survey_id][:event_name]][:conditions][:answer_ids].sort == user_answer_ids.sort
      end
      events_participated_in << @@rules[:surveys][survey_id][:event_name] if in_event
    end
    @@event_order & events_participated_in
  end

private
  def build_index
    index = {}
    index[:surveys] = {}
    Survey.all.each do |survey|
      index[:surveys][survey.id] = {}
      index[:surveys][survey.id][:event_id] = survey.event.id if survey.event
      index[:surveys][survey.id][:event_name] = survey.event.name if survey.event
    end
    index[:events] = {}
    Event.all.each do |event|
      index[:events][event.name] = {}
      index[:events][event.name][:conditions] = {}

      index[:events][event.name][:conditions][:modifier] = 'any_of'
      case event.name
      when "Women's March"
        index[:events][event.name][:conditions][:answer_ids] = event.surveys.collect{|s| s.sections.collect{|ss| ss.questions.reject{|q| q.short_text == 'WMoS volunteer pool'}}}.flatten.collect{|q| q.answers.select{|a| a.text == 'Yes'}}.flatten.collect{|a| a.id}
      when "Community Convergence"
        index[:events][event.name][:conditions][:answer_ids] = event.surveys.collect{|s| s.sections.collect{|ss| ss.questions}}.flatten.collect{|q| q.answers.select{|a| a.text == 'Yes'}}.flatten.collect{|a| a.id}
      when "Womxn Act on Seattle"
        index[:events][event.name][:conditions][:answer_ids] = event.surveys.collect{|s| s.sections.collect{|ss| ss.questions}}.flatten.collect{|q| q.answers.select{|a| a.text == 'Yes'}}.flatten.collect{|a| a.id}
      when "Families Belong Together"
        []
      when "Womxn Connect Seattle"
        index[:events][event.name][:conditions][:answer_ids] = event.surveys.collect{|s| s.sections.collect{|ss| ss.questions.select{|q| q.short_text == 'Volunteer type' || q.short_text == 'Volunteer:'}}}.flatten.collect{|q| q.answers.select{|a| a.short_text == 'Peacekeeper' || a.short_text == 'peacekeeper'}}.flatten.collect{|a| a.id}
      else
        []
      end
    end
    index
  end

  def get_event_order
    Event.all.order(:start_date).pluck(:name)
  end


end
