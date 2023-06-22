class PostCompanyApi
  API_BASE_URL = 'http://localhost:5000/api/v1/companies'.freeze
  attr_reader :company

  def initialize(attributes)
    @company = attributes
  end

  def send
    Faraday.post(API_BASE_URL, @company.to_json, 'Content-Type' => 'application/json')
  rescue Faraday::ConnectionFailed
    500
  end
end
