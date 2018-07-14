class Event < ApplicationRecord

  has_many :surveys, dependent: :destroy

  validates :name, presence: true
  validates :start_date, presence: true

  after_create :auto_set_dates, unless: :all_dates_blank?

private
  def all_dates_blank?
    [start_date, end_date, leadup_date, followup_date].compact.empty?
  end

  def auto_set_dates
    self.end_date ||= self.start_date
    self.leadup_date ||= Date.today
    self.followup_date ||= self.end_date + 1.month
    self.save
  end
end
