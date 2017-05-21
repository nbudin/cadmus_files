require "cadmus_files/version"

require "cadmus"

require "cadmus_files/engine"
require "cadmus_files/file"
require "cadmus_files/file_url_tag"
require "cadmus_files/admin_controller"

module CadmusFiles
  extend Cadmus::Concerns::OtherClassAccessor
  other_class_accessor :file_model
end
