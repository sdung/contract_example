class ContractServices < AbstractServices
  def create_contract(params)
    repo = MetaComet::Repository.new("Contract")
    begin
      contract = repo.create(params)
    rescue ActiveRecord::RecordNotUnique
      contract = repo.new(params)
      contract.record_not_unique
      raise ValidationError.new(contract)
    end
    raise ValidationError.new(contract) if !contract.valid? || contract.errors.any?
    contract
  end
end