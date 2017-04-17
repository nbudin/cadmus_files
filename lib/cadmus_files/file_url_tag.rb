require 'liquid'

module CadmusFiles
  class FileUrlTag < Liquid::Tag
    attr_reader :filename

    def initialize(tag_name, args, tokens)
      super
      @filename = args.strip.gsub(/\A([\"\'])(.*)\1\z/, '\2')
    end

    def render(context)
      file_model = CadmusFiles.file_model

      unless file_model
        return "Error: CadmusFiles.file_model not set.  Please set it to your file model in an initializer."
      end

      parent = context.registers['parent']
      cms_file = file_model.find_by(file_model.cadmus_file_field => filename, parent: parent)
      unless cms_file
        return "Error: file #{filename} not found"
      end

      cms_file.file.url
    end
  end

  Liquid::Template.register_tag('file_url', FileUrlTag)
end

