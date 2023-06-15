class CardType
  attr_reader :id, :name, :icon, :start_points, :conversion_tax

  def initialize(attributes = {})
    @id = attributes['id']
    @name = attributes['name']
    @icon = attributes['icon']
    @start_points = attributes['start_points']
    @conversion_tax = attributes['conversion_tax']
  end

  def self.all(cnpj)
    response = Faraday.get("http://localhost:4000/api/v1/company_card_types?cnpj=#{cnpj}")
    card_types_array = JSON.parse(response.body)
    card_types_array.map { |hash| new(hash) }
  end

  def self.find(id, cnpj)
    all(cnpj).detect { |card_type| card_type.id == id }
  end
end
