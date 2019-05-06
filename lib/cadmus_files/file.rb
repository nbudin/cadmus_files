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

        has_one_attached :file
        validate :validate_file_name_is_unique

        define_method :to_param do
          "#{id}-#{filename.to_param}"
        end

        define_method :filename do
          ::File.basename(blob.filename)
        end

        define_method :is_image? do
          blob.content_type =~ /\Aimage\//
        end

        private

        define_method :blob do
          send(file_field).attachment&.blob
        end

        define_method :validate_file_name_is_unique do
          the_filename = blob.filename

          scope = parent ? self.class.base_class.where(parent: parent) : self.class.global
          blob_scope = ActiveStorage::Blob.where(
            id: ActiveStorage::Attachment.where(
              record_id: scope.select(:id),
              record_type: self.class.base_class.name
            ).select(:blob_id)
          )
          if blob_scope.where(filename: the_filename).any?
            errors.add file_field, "'#{the_filename}' already exists"
          end
        end
      end
    end
  end
end
