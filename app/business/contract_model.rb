class ContractModel < AbstractModel
  attr_accessor :name

  validates :name, :presence => true

  def attributes=(attributes)
    @name = attributes[:name]
  end
end