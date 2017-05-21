module CadmusFiles
  module File
    extend ActiveSupport::Concern
    include Cadmus::Concerns::ModelWithParent

    module ClassMethods
      def cadmus_file(file_field = 'file')
        class << self
          attr_accessor :cadmus_file_field
        end
        self.cadmus_file_field = file_field

        model_with_parent

        validates_integrity_of file_field
        validates_processing_of file_field
        validate :validate_file_name_is_unique

        define_method :to_param do
          "#{id}-#{filename.to_param}"
        end

        define_method :filename do
          ::File.basename(send(file_field).path)
        end

        define_method :is_image? do
          send(file_field).content_type =~ /\Aimage\//
        end

        private

        define_method :validate_file_name_is_unique do
          the_filename = send(file_field).filename

          if self.class.base_class.where(file_field => the_filename).any?
            errors.add file_field, "'#{the_filename}' already exists"
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, CadmusFiles::File