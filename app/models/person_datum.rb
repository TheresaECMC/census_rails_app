class PersonDatum < ActiveRecord::Base
  belongs_to :person

  before_save :set_up

  def set_up
    parsed_call       = JSON.parse(json_hash)
    self.state_pop = parsed_call[1][0]
    self.age_pop = nil
    self.gender_pop = parsed_call[1][1]
    self.gender_race_pop = parsed_call[1][2]
    self.gender_age_pop   = parsed_call[1][3]
    self.gender_age_and_race_pop = parsed_call[1][4]
  end

  def person_per_sq_miles
    milage = person.state.land_area.to_f / gender_age_and_race_pop.to_f 
    milage.round(2)
  end


end