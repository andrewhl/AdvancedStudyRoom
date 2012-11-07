class TiersController < ApplicationController
  def new
    @tier = Tier.new
  end

  def create
    # @tier = Tier.create(params[:tier])
    @league = League.find(params[:league_id])
    @tier = @league.tiers.create(params[:tier])
    # binding.pry
    redirect_to league_path(@league.id), :notice => "Your tier has been successfully created."
  end

  def destroy
    binding.pry
    tier = Tier.find(params[:id])
    tier.destroy
    redirect_to league_path(@league.id), :notice => "The tier has been deleted."
  end

  def index
    @tiers = Tier.all
  end

end
