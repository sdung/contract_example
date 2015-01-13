class ContractServices
  class ValidationError < StandardError
    def initialize(model)
      @model = model
    end
  end

  def create_contract(params)
    contract = ContractModel.new(params)
    raise ValidationError.new(contract) unless contract.valid?
    contract.save
    contract
  end
end