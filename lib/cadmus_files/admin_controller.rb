module CadmusFiles
  module AdminController
    extend ActiveSupport::Concern

    included do
      helper 'cadmus_files/admin'
    end

    def index
      @cms_files = cms_file_scope
      render template: 'cadmus/files/index'
    end

    def create
      @cms_file = cms_file_scope.create!(cms_file_params)
      redirect_to action: 'index'
    end

    def destroy
      @cms_file = cms_file_scope.find(params[:id])
      @cms_file.destroy

      redirect_to action: 'index'
    end

    protected

    def cms_file_scope
      CadmusFiles.file_model.all
    end

    def cms_file_params
      params.require(:cms_file).permit(:file)
    end
  end
end