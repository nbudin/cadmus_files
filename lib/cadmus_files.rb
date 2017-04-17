require "cadmus_files/version"
require "cadmus_files/engine"
require "cadmus_files/file"
require "cadmus_files/file_url_tag"
require "cadmus_files/admin_controller"

module CadmusFiles
  class << self
    def file_model
      @_file_model ||= @_file_model_name.safe_constantize
    end

    def file_model=(file_model)
      @_file_model_name = case file_model
      when Class then file_model.name
      else file_model
      end
    end

    def clear_file_model_cache!
      @_file_model = nil
    end
  end
end
