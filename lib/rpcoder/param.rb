require 'camelizer'

module RPCoder
  class Param
    def self.original_types
      [:int, :String, :Boolean, :Array]
    end

    attr_accessor :name, :type, :options
    def initialize(name, type, options = {})
      @name = name
      @type = type
      @options = options
    end

    def array?
      options[:array?]
    end

    def array_or_type
      if array?
        "#{to_c_sharp_type}[]"
      else
        to_c_sharp_type
      end
    end

    def to_c_sharp_type
      case type.to_sym
      when :int
        return :int?
      when :String
        return :string
      when :Boolean
        return :bool?
      else
        return type
      end
    end

    def original_type?
      Param.original_types.include?(type.to_sym)
    end

    def array_param
      Param.new(name, options[:array_type])
    end

    def instance_creator(elem = 'elem', options = {})
      elem = element_accessor(elem, options)
      if original_type?
        elem
      else
        "new #{type}(#{elem})"
      end
    end

    def element_accessor(elem = 'elem', options = {})
      if options[:object?]
        "object['#{elem}']"
      else
        elem
      end
    end

  end
end

