require 'camelizer'

module RPCoder
  class Param
    def self.original_types
      [:int, :Int, :double, :Double, :string, :String, :bool, :Boolean, :Array]
    end

    attr_accessor :name, :type, :options, :description
    def initialize(name, type, options = {})
      @name = name
      @type = type
      @options = options
      @description = options[:desc] if options[:desc]
    end

    def array?
      options[:array?]
    end

    def optional?
      options[:require] == false or options[:nullable] == true
    end

    def nullable_enum?
      options[:nullable] == true
    end

    def array_or_type
      if array?
        "List<#{to_c_sharp_type}>"
      else
        to_c_sharp_type
      end
    end

    def to_c_sharp_type
      case type.to_sym
      when :int
        if self.optional?
          return :int?
        else
          return :int
        end
      when :Int
        if self.optional?
          return :int?
        else
          return :int
        end
      when :double
        if self.optional?
          return :double?
        else
          return :double
        end
      when :Double
        if self.optional?
          return :double?
        else
          return :double
        end
      when :string
        return :string
      when :String
        return :string
      when :bool
        if self.optional?
          return :bool?
        else
          return :bool
        end
      when :Boolean
        if self.optional?
          return :bool?
        else
          return :bool
        end
      else
        if self.nullable_enum?
          return type + "?"
        else
          return type
        end
      end
    end

    def to_json_type?
      case type.to_sym
      when :int
        return "IsInt"
      when :Int
        return "IsInt"
      when :double
        return "IsDouble"
      when :Double
        return "IsDouble"
      when :string
        return "IsString"
      when :String
        return "IsString"
      when :bool
        return "IsBoolean"
      when :Boolean
        return "IsBoolean"
      else
        return type
      end
    end

    def original_type?
      Param.original_types.include?(type.to_sym)
    end

    def double?
      self.to_json_type? == "IsDouble"
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

