class Reservation < ApplicationRecord
    belongs_to :user 
    belongs_to :room 


    validates :person_num, presence: true
    validates :reservation_start_date, presence: true
    validates :reservation_end_date, presence: true
    validates :person_num, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
    validate :reservation_start_date_cannot_be_in_the_past
    validate :reservation_end_date_cannot_be_in_the_past
  def reservation_start_date_cannot_be_in_the_past
    if reservation_start_date.present? && reservation_start_date < Date.today
      errors.add(:reservation_start_date, "は本日以降の日付で選択してください。")
    end
  end
  def reservation_end_date_cannot_be_in_the_past
      if reservation_end_date.present? &&  reservation_end_date <= reservation_start_date
          errors.add(:reservation_end_date, "はチェックイン日より後の日付で選択してください。")
      end
  end
end
