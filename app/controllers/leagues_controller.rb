class LeaguesController < ApplicationController
  def new
    @league = League.new
    @servers = Server.all
  end

  def create

    # if params[:tier] make a tier, if params[:league] make a league, etc...
    # render show page

    @league = League.create(params[:league])
    redirect_to :new_league, :notice => "Your league has been successfully created."
  end

  def destroy
    league = League.find(params[:id])
    league.destroy
    redirect_to :leagues, :notice => "The league has been deleted."
  end

  def index
    @leagues = League.all
  end

  def show
    @league = League.find(params[:id])
    @tier = Tier.new
    @tiers = @league.tiers
    @division = Division.new
    @divisions = @tier.divisions
  end
end
