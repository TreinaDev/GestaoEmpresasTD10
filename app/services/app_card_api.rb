class AppCardApi
  API_BASE_URL = 'http://localhost:4000/api/v1'.freeze
  attr_reader :card

  def initialize(attributes)
    @card = attributes
  end

  def send
    new_card = new_card.to_json
    Faraday.post("#{API_BASE_URL}/cards", new_card, 'Content-Type' => 'application/json')
  rescue Faraday::ConnectionFailed
    500
  end
end
