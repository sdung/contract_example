class ContractServices < AbstractServices
  def initialize
    @@repo = MetaComet::Repository.new("Contract")
  end

  def all
    @@repo.all
  end

  def find(id)
    @@repo.find(id)
  end

  def dummy
    @@repo.new
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

  def update_contract(contract, params)
    begin
      contract = @@repo.update(contract.id, params)
    rescue ActiveRecord::RecordNotUnique
      contract = @@repo.new(params)
      contract.record_not_unique
      raise ValidationError.new(contract)
    end
    raise ValidationError.new(contract) if !contract.valid? || contract.errors.any?
    contract
  end

  def delete_contract(id)
    contract = @@repo.find(id)
    @@repo.destroy(contract.id)
  end
end