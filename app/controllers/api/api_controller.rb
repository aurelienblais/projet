class Api::ApiController < ApplicationController
  def index
    render json: {}, status: :ok
  end
end
