class PeopleController < ApplicationController

  def new
    if created_first_admin
      @person = Person.new(name: current_user.name)
      @text = "Create Your Profile Info"
    else
      @person = Person.new(user: current_user)
      @text = "Create A Family Member"
    end
  end

  def create
    @person = Person.new
    if person_params[:male] == "false"
      sex = false
    else
      sex = true
    end
    if @person.update_attributes(person_params) && @person.update_attributes(male: sex, active_user: created_first_admin, user: current_user)
      cencus = CencusCall.new(@person)
      PersonDatum.create(json_hash: cencus.call_data, person: @person)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @people = Person.where(user: current_user)
  end

  private

  def person_params
    params.require(:person).permit(:name, :male, :age, :state_id, :race_id, :city)
  end

end
