require 'model_base'

class Contract_Model
  extend ActiveModel::Naming
  include ActiveModel::Validations
  include MetaComet::ModelBase

  attr_accessor :name, :id

  validates :name, :presence => true

  def initialize(param = nil)
    super(param)
  end

   def record_not_unique
     self.errors.add(:name, "must be Unique")
   end
end