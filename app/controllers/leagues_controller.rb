class LeaguesController < ApplicationController
  def new
    @league = League.new
    @servers = Server.all
  end

  def create
    @league = League.create(params[:league])
    # binding.pry
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
    # @tier = @league.tiers.build
    @tier = Tier.new
    @tiers = @league.tiers
  end
end
