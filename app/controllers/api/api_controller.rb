class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  after_filter :cors_set_access_control_headers

  def index
    render json: {}, status: :ok
  end

  private

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin']   = '*'
    headers['Access-Control-Allow-Methods']  = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers']  = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
