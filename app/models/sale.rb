class Sale < ActiveRecord::Base

  def self.active
    where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end
  def ended?
    ends_on < Date.current
  end
  def upcoming?
    starts_on > Date.current
  end

  def active?
    !upcoming && !ended
  end
end