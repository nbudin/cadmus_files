module CadmusFiles
  class Engine < Rails::Engine
    config.to_prepare do
      CadmusFiles.clear_file_model_cache!
    end
  end
end