class GetCardApi
  API_BASE_URL = 'http://localhost:4000/api/v1/'.freeze
  attr_reader :cpf, :number, :points, :status, :name

  def initialize(attributes = {})
    @id = attributes['id']
    @name = attributes['name']
    @number = attributes['number']
    @points = attributes['points']
    @status = attributes['status'].downcase
  end

  def self.show(cpf)
    response = Faraday.get("#{API_BASE_URL}cards/#{cpf}")
    GetCardApi.new(JSON.parse(response.body)) if response.status == 200
  end
end