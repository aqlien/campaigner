class Event < ApplicationRecord

  has_many :surveys, dependent: :destroy

  validates :name, presence: true

  after_create :auto_set_dates, unless: :all_dates_blank?

private
  def all_dates_blank?
    [start_date, end_date, leadup_date, followup_date].compact.empty?
  end

  def auto_set_dates
    self.start_date ||= Date.today + 1.month   #TODO: Should we validate presence of start_date instead?
    self.end_date ||= self.start_date
    self.leadup_date ||= self.start_date - 1.month
    self.followup_date ||= self.end_date + 1.month
    self.save
  end
end
