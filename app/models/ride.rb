class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    if not_enough_tickets && not_enough_height
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    elsif not_enough_tickets
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif not_enough_height
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    else self.user.update(
      tickets: self.user.tickets - self.attraction.tickets,
      nausea: self.user.nausea + self.attraction.nausea_rating,
      happiness: self.user.happiness + self.attraction.happiness_rating)
    end
  end

  def not_enough_tickets
    self.user.tickets < self.attraction.tickets
  end

  def not_enough_height
    self.user.height < self.attraction.min_height
  end

end
