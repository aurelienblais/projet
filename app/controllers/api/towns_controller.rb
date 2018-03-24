class Api::TownsController < Api::ApiController
  def index
    render json: Town.all, each_serializer: TownSummarySerializer
  end

  def show
    render json: Town.find(params[:id]), serializer: TownSerializer
  end
end
