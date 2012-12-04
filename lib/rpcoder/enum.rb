require 'rpcoder/param'
require 'camelizer'

module RPCoder
  class Enum
    attr_accessor :name, :description, :flags

    def initialize
      @num = 0
    end

    def constants
      @constants ||= []
    end

    def flags?
      @flags
    end

    def add_constant(name, options = {})
      if self.flags? and @num == 0
        @num = 1
      end
      if options[:num]
        @num = options[:num]
      end
      constants << EnumItem.new(name, @num, options)
      if self.flags?
        @num *= 2
      else
        @num += 1
      end
      constants
    end

    class EnumItem
      attr_accessor :name, :num, :options, :description

      def initialize(name, num, options = {})
        @name = name
        @num = num
        @options = options
        @description = options[:desc] if options[:desc]
      end
    end
  end
end
