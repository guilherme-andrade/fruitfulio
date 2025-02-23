require 'faraday'
require 'json'

class FatSecretClient
  BASE_URL = 'https://platform.fatsecret.com/rest/server.api'

  def initialize(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
    @access_token = fetch_access_token
    @connection = Faraday.new(url: BASE_URL) do |conn|
      conn.request :url_encoded
      conn.response :json, content_type: /\bjson$/
      conn.adapter Faraday.default_adapter
    end
  end

  def search_foods(query)
    response = @connection.get do |req|
      req.params['method'] = 'foods.search'
      req.params['search_expression'] = query
      req.params['format'] = 'json'
      req.params['oauth_token'] = @access_token
    end
    handle_response(response)
  end

  def get_food_details(food_id)
    response = @connection.get do |req|
      req.params['method'] = 'food.get'
      req.params['food_id'] = food_id
      req.params['format'] = 'json'
      req.params['oauth_token'] = @access_token
    end
    handle_response(response)
  end

  private

  def fetch_access_token
    response = Faraday.post('https://platform.fatsecret.com/rest/server.api') do |req|
      req.body = {
        grant_type: 'client_credentials',
        client_id: @client_id,
        client_secret: @client_secret
      }
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
    end

    if response.success?
      JSON.parse(response.body)['access_token']
    else
      raise "Failed to obtain access token: #{response.status} - #{response.body}"
    end
  end

  def handle_response(response)
    if response.success?
      response.body
    else
      raise "API request failed: #{response.status} - #{response.body}"
    end
  end
end 
