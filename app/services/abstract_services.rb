class AbstractServices
  def initialize
    @@repo = MetaComet::Repository.new("Contract")
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