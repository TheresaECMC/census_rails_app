# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

states = State.create([{name: "Alabama", state_number: "01"}, {name: "Alaska", state_number: "02"}, {name: "Arizona", state_number: "04"}, {name: "Arkansas", state_number: '05'}, {name: "California", state_number: '06'}, {name: "Colorado", state_number: '08'}, {name: "Connecticut", state_number: '09'}, {name: "District of Columbia", state_number: '11', land_area: 61}, {name: "Delaware", state_number: '10'}, {name: "Florida", state_number: '12'}, {name: "Georgia", state_number: '13'}, {name: "Hawaii", state_number: '15'}, {name: "Idaho", state_number: '16'}, {name: "Illinois", state_number: 17}, {name: "Indiana", state_number: 18}, {name: "Iowa", state_number: '19'}, {name: "Kansas", state_number: '20'}, {name: "Kentucky", state_number: '21'}, {name: "Louisiana", state_number: 22}, {name: "Maine", state_number: 23}, {name: "Maryland", state_number: '24'}, {name: "Massachusetts", state_number: '25'}, {name: "Michigan", state_number: '26'}, {name: "Minnesota", state_number: '27'}, {name: "Mississippi", state_number: '28'}, {name: "Missouri", state_number: '29'}, {name: "Montana", state_number: '30'}, {name: "Nebraska", state_number: '31'}, {name: "Nevada", state_number: '32'}, {name: "North Carolina", state_number: '37'}, {name: "North Dakota", state_number: '38'}, {name: "New Hampshire", state_number: '33'}, {name: "New Jersey", state_number: '34'}, {name: "New Mexico", state_number: '35'}, {name: "New York", state_number: '36'}, {name: "Ohio", state_number: '39'}, {name: "Oklahoma", state_number: '40'}, {name: "Oregon", state_number: '41'}, {name: "Pennsylvania", state_number: '42'}, {name: "Rhode Island", state_number: '44'}, {name: "South Carolina", state_number: '45'}, {name: "South Dakota", state_number: '46'}, {name: "Tennessee", state_number: '47'}, {name: "Texas", state_number: '48'}, {name: "Utah", state_number: '49'}, {name: "Virginia", state_number: '51'}, {name: "Vermont", state_number: '50'}, {name: "Washington", state_number: '53'}, {name: "Wisconsin", state_number: '55'}, {name: "West Virginia", state_number: '54'}, {name: "Wyoming", state_number: '56'}])

races = Race.create([{name: "white", race_letter: "A"}, {name: "black", race_letter: "B"}, {name: "American Indian", race_letter: "C"}, {name: "Asian", race_letter: "D"}, {name: "Pacific Islander", race_letter: "E"}, {name: "Hispanic/Latino", race_letter: "H"}, {name: "another race", race_letter: "F"}, {name: "two or more races", race_letter: "G"}])

user = User.create(name: "Admin", email: "a@a.a", password: "Password12", password_confirmation: "Password12")
aziz_photo = File.open('db/seed_pictures/aziz_pic.jpg')
aziz = Person.create(name: "Aziz", age: 32, race: Race.find_by(name: "Asian"), male: true, active_user: false, state: State.find_by(name: "South Carolina"), user: nil, city: "Charleston", photo: aziz_photo)

michele_photo = File.open('db/seed_pictures/michele_pic.jpg')
michele = Person.create(name: "Michele", age: 59, race: Race.find_by(name: "white"), male: false, active_user: false, state: State.find_by(name: "Minnesota"), user: nil, city: "St. Cloud", photo: michele_photo)


census = CensusCall.new(michele)
PersonDatum.create(json_hash: census.call_data, person: michele)
census2 = CensusCall.new(aziz)
PersonDatum.create(json_hash: census2.call_data, person: aziz)

# These lines of code are using Nokogiri to add the land_area to each of the states cause I didn't want to do it by hand.

def make_noko_giri_parse
  page = Nokogiri::HTML(RestClient.get("http://www.theus50.com/fastfacts/area.php"))
  state_info = page.css('td')
end

def fill_in_state_land_area
  state_info = make_noko_giri_parse
  i = 0
  while i < 150 do
    state = State.find_by(name: state_info[i].text)
    if state != nil
      state.update_attributes(land_area: state_info[(i + 1)].text.gsub(",", "").to_i)
    else
    end
    i += 1
  end  
end

fill_in_state_land_area
