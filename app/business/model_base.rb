module MetaComet
  module ModelBase

    def initialize(param = nil)

      if !param.nil?
        case
          when param.is_a?(Hash)
            attributes = param

          when param.is_a?(self.class.name.gsub('_Model', '').constantize)
            attributes = param.attributes

          else
            raise "Parameter must be an instance of \'#{self.class.name.gsub('_Model', '')}\' or a hash that" +
                      " contains the appropriate symbols for #{self.class.name}"
        end

        attributes.each do |k, v|
          send("#{k}=", v) if respond_to? "#{k}="
        end

      end
    end

    def to_hash
      hash = Hash.new

      self.instance_variables.each do |var|
        attrib = var.to_s.gsub!('@', '')

        if !%w[errors validation_context].include?(attrib)
          hash[attrib.to_sym] = self.instance_variable_get(var)
        end
      end

      hash
    end

    def to_param
      self.id
    end

    def record_not_unique
      self.errors.add(:base, "Record not unique")
    end

  end
end