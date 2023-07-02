class GetCardApi
  API_BASE_URL = 'http://localhost:4000/api/v1/'.freeze
  attr_reader :id, :cpf, :number, :points, :status, :name, :icon

  def initialize(attributes = {})
    @id = attributes['id']
    @name = attributes['name']
    @number = attributes['number']
    @points = attributes['points']
    @status = attributes['status'].downcase
    @icon = attributes['icon']
  end

  def self.show(cpf)
    response = Faraday.get("#{API_BASE_URL}cards/#{cpf}")
    GetCardApi.new(JSON.parse(response.body)) if response.status == 200
  rescue Faraday::ConnectionFailed
    500
  end

  def self.deactivate(id)
    response = Faraday.patch("#{API_BASE_URL}cards/#{id}/deactivate")
    return response.status if response.status == 200
  rescue Faraday::ConnectionFailed
    500
  end

  def self.activate(id)
    response = Faraday.patch("#{API_BASE_URL}cards/#{id}/activate")
    return response.status if response.status == 200
  rescue Faraday::ConnectionFailed
    500
  end

  def self.status
    Faraday.get(API_BASE_URL)
  end
end
