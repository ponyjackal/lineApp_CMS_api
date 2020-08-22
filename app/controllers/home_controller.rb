class HomeController < ActionController::API
  def index
    render json: {response: 'API working'}
  end
end