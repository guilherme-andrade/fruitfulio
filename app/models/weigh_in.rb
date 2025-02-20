class WeighIn < ApplicationRecord
  belongs_to :user

  validate :user_has_only_measured_once_today

  def measured_on
    measured_at.to_date
  end

  def weight_kg
    weight_g.to_f / 1000
  end

  private

  def user_has_only_measured_once_today
    weigh_ins = WeighIn.where(user_id: user_id, measured_at: measured_at.all_day)
    return if weigh_ins.empty?

    errors.add(:base, :already_measured_today)
  end
end
