class AbstractServices
  def initialize(model_name = nil)
    raise ArgumentError.new("model_name is required") if model_name.nil?
    raise ArgumentError.new("model_namee must be a string") if !model_name.is_a? String
    raise ArgumentError.new("model_name must not be blank") if model_name.length < 1
    @@repo = MetaComet::Repository.new(model_name)
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

  class ValidationError < StandardError
    def initialize(model)
      @model = model
    end

    def model
      @model
    end
  end
end