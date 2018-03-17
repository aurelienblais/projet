class Api::TownsController < Api::ApiController
  def index
    render json: Town.all
  end

  def show
    render json: Town.find(params[:id]), serializer: TownSerializer
  end
end