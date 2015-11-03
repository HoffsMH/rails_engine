class Api::V1::BaseApiController < ApplicationController
    respond_to :json
    def index
      respond_with object_type.all
    end

    def show
      respond_with object_type.find_by(id: show_params)
    end

    def find
      respond_with  object_type.find_by(find_params)
    end

    def find_all
      respond_with  object_type.where(find_params)
    end

    def random
      respond_with  object_type.all.sample
    end

    private
    def find_params
      object_type_params = object_type.column_names.map {|name| name.to_sym}
      params.permit(*object_type_params)
    end

    def show_params
      params.require(:id)
    end
end
