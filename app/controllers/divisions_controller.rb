class DivisionsController < ApplicationController
  def new
    @division = Division.new
  end

  def create
    @division = Division.create(params[:division])
    # binding.pry
    redirect_to :new_division, :notice => "Your division has been successfully created."
  end

  def destroy
    division = Division.find(params[:id])
    division.destroy
    redirect_to :divisions, :notice => "The division has been deleted."
  end

  def index
    @divisions = Division.all
  end

end
