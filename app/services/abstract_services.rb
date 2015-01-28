require 'repository'

class AbstractServices
  def initialize(model_name = nil)
    raise ArgumentError, 'model_name is required' if model_name.nil?
    raise ArgumentError, 'model_name must be a string' if !model_name.is_a? String
    raise ArgumentError, 'model_name must not be blank' if model_name.length < 1
    @@repo = MetaComet::Repository.new(model_name)
  end

  def all
     @@repo.all
  end

  def find(id)
    begin
      @@repo.find(id)

    rescue MetaComet::RepositoryError => e
      raise StandardError, e.message

    end
  end

  def dummy
    @@repo.new
  end

  def create(params)
    begin
      model = @@repo.create(params)
      raise ValidationError.new(model) if !model.valid? || model.errors.any?
      model
    rescue MetaComet::RepositoryUniqueError
      model = @@repo.new(params)
      model.record_not_unique
      raise ValidationError.new(model)
    end
  end

  def update(id, params)
    begin
      model = @@repo.update(id, params)
    rescue MetaComet::RepositoryUniqueError
      model = @@repo.new(params)
      model.record_not_unique
      raise ValidationError.new(model)
    rescue MetaComet::RepositoryError => e
      raise StandardError, e.message
    end
    raise ValidationError.new(model) if !model.valid? || model.errors.any?
    model
  end

  def delete(id)
    begin
      @@repo.destroy(id)
    rescue MetaComet::RepositoryError => e
      raise StandardError, e.message
    end
  end

  class ValidationError < StandardError
    def initialize(model)
      @model = model
    end

    def model
      @model
    end
  end
end