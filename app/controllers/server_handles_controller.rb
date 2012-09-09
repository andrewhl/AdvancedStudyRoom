class ServerHandlesController < ApplicationController

  def new
    @handle = ServerHandle.find(params[:id])
  end

  def create
    @handle = ServerHandle.create(params[:server_handle])
  end

  def destroy

  end

end