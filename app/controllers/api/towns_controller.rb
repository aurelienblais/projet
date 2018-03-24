class Api::TownsController < Api::ApiController
  def index
    render json: Town.all, each_serializer: TownSummarySerializer
  end

  def create
    town = Town.new name: params[:name]
    render_town(town.save, town)
  end

  def show
    render json: Town.find(params[:id]), serializer: TownSerializer
  end

  def update
    town = Town.find_by id: params[:id]
    render_town(town.nil? ? false : town.update_attributes(name: params[:name]), town)
  end

  private

  def render_town(success, town)
    if success
      render json: town
    else
      head :internal_server_error
    end
  end
end
