# encoding: utf-8

require 'erb'
require 'rpcoder/function'
require 'rpcoder/type'
require 'rpcoder/enum'

VERSION = "1.0.4"

module RPCoder
  class << self
    @@templates = ["API", "Interface", "Dummy", "DummyServer", "EnumDefinitions", "Responses", "JsonExtensions"]
    @@extra_templates = []

    def name_space=(name_space)
      @name_space = name_space
    end

    def name_space
      @name_space
    end

    def api_class_name=(name)
      @api_class_name = name
    end

    def api_class_name
      @api_class_name
    end

    def types
      @types ||= []
    end

    def type(name)
      type = Type.new
      type.name = name
      yield type
      types << type
      type
    end

    def functions
      @functions ||= []
    end

    def function(name)
      func = Function.new
      func.name = name
      yield func
      functions << func
      func
    end

    def enums
      @enums ||= []
    end

    def enum(name)
      enum = Enum.new
      enum.name = name
      yield enum
      enums << enum
      enum
    end

    def add_template(item_name, template_path)
      @@extra_templates << {:path => item_name, :template => template_path}
    end

    def create_binding(name)
      {:path => name, :template => template_path(name) }
    end

    def get_export_file_name(class_dir, name)
      File.join(class_dir, api_class_name.split('.').last + name + ".cs")
    end

    def render_erb(template, _binding)
      ERB.new(File.read(template, :encoding => Encoding::UTF_8), nil, '-').result(_binding)
    end

    def template_path(name)
      File.join File.dirname(__FILE__), 'templates', name + '.erb'
    end

    def export(dir)
      class_dir = dir_to_export_classes(dir)
      FileUtils.mkdir_p(class_dir)
      @@templates.map { |name|
        create_binding(name)
      }.concat(@@extra_templates).each do |hash|
        path = get_export_file_name(class_dir, hash[:path])
        puts "API: #{path}"
        File.open(path, "w") { |file| file << render_erb(hash[:template], binding) }
      end
      types.each { |type| export_type(type, 'Type', File.join(class_dir, "#{type.name}.cs")) }
      types.each { |type| export_type(type, 'TypeJson', File.join(class_dir, "#{type.name}.json.cs")) }
    end

    def export_type(type, template_name, path)
      puts "Type: #{path}"
      File.open(path, "w") { |file| file << render_type(type, template_name) }
    end

    def render_type(type, template_name)
      render_erb(template_path(template_name), binding)
    end

    def dir_to_export_classes(dir)
      File.join(dir, *name_space.split('.'))
    end

    def clear
      functions.clear
      types.clear
    end

    def version
      VERSION
    end
  end
end
