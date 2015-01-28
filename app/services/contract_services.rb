class ContractServices < AbstractServices
  def initialize
    super("Contract")
  end

  def create_contract(params)
    begin
      contract = @@repo.create(params)
    rescue ActiveRecord::RecordNotUnique
      contract = @@repo.new(params)
      contract.record_not_unique
      raise ValidationError.new(contract)
    end
    raise ValidationError.new(contract) if !contract.valid? || contract.errors.any?
    contract
  end

  def update_contract(id, params)
    begin
      contract = @@repo.find(id)
      contract = @@repo.update(contract.id, params)
    rescue ActiveRecord::RecordNotUnique
      contract = @@repo.new(params)
      contract.record_not_unique


    end
    raise ValidationError.new(contract) if !contract.valid? || contract.errors.any?
    contract
  end

  def delete_contract(id)
    contract = @@repo.find(id)
    @@repo.destroy(contract.id)
  end
end