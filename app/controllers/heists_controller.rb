class HeistsController < ApplicationController
  respond_to :json
  
  def index
    @heists = Heist.all
    respond_with @heists
  end

  def show
    @heist = Heist.find(params[:id])
    if @heist
      respond_with @heist
    else
      render status: 404
    end
  end
  
  def create
    @heist = Heist.new(params[:heist])
    if @heist.save
      render status: 201, json: @heist.to_json
    end
  end

  def update
  end
  
  def destroy
  end
  
end
