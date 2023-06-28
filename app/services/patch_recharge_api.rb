class PatchRechargeApi
  API_BASE_URL = 'http://localhost:4000/api/v1/cards/recharge'.freeze

  def initialize(attributes)
    @recharge = attributes
  end

  def send
    response = Faraday.patch(API_BASE_URL, @recharge.to_json, 'Content-Type' => 'application/json')
  #   { status: response.status, body: JSON.parse(response.body) }
  # rescue Faraday::ConnectionFailed
  #   { status: 500, body: nil }
  end
end
