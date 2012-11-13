class TiersController < ApplicationController
  before_filter :league_id, :only => [:create, :destroy]

  def new
    @tier = Tier.new
  end

  def create
    @tier = @league.tiers.create(params[:tier])

    if @tier.errors.any?
      notice_msg = "The tier was not created. There were errors."
    else
      notice_msg = "The tier has been successfully created."
    end

    redirect_to league_path(@league.id), :notice => notice_msg
  end

  def destroy
    tier = Tier.find(params[:id])
    tier.destroy

    redirect_to league_path(@league.id), :notice => "The tier has been deleted."
  end

  def index
    @tiers = Tier.all
  end

  private

    def league_id
      @league = League.find(params[:league_id])
    end

end
