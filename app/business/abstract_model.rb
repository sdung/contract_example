class AbstractModel
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def initialize(attributes = {})
    self.attributes = attributes
  end

  def persisted?
    false
  end

  def save

  end
end