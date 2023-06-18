class CardType
  API_BASE_URL = 'http://localhost:4000/api/v1/company_card_types'.freeze
  attr_reader :id, :name, :icon, :start_points, :conversion_tax

  def initialize(attributes = {})
    @id = attributes['id']
    @name = attributes['name']
    @icon = attributes['icon']
    @start_points = attributes['start_points']
    @conversion_tax = attributes['conversion_tax']
  end

  def self.all(cnpj)
    response = Faraday.get("#{API_BASE_URL}?cnpj=#{cnpj.tr('^0-9', '')}")
    card_types_array = JSON.parse(response.body)
    card_types_array.map { |hash| new(hash) }
  end

  def self.find(id, cnpj)
    all(cnpj).detect { |card_type| card_type.id == id }
  end

  def self.status
    Faraday.get(API_BASE_URL).status
  rescue Faraday::ConnectionFailed
    500
  end
end
