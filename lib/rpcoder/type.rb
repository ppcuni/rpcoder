require 'rpcoder/param'
require 'camelizer'

module RPCoder
  class Type
    attr_accessor :name, :description, :array_type

    def fields
      @fields ||= []
    end

    def add_field(name, type, options = {})
      options[:array_type] = @array_type if options[:array_type] == nil
      fields << Field.new(name, type, options)
    end

    def array
      if @array_type == :array
        "#{name}[]"
      else
        "List<#{name}>"
      end
    end

    class Field < Param
      attr_accessor :default
      def initialize(name, type, options = {})
        super(name, type, options)
        @default = options[:default]
      end
    end
  end
end
