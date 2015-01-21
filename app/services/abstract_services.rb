class AbstractServices
  class ValidationError < StandardError
    def initialize(model)
      @model = model
    end

    def model
      @model
    end
  end
end