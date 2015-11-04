class Api::V1::BaseApiController < ApplicationController
    respond_to :json
    def index
      respond_with object_type.all
    end

    def show
      object = object_type.find_by(id: show_params)

      object ? respond_with(object) : not_found
    end

    def find
      object = object_type.find_by(find_params)

      object ? respond_with(object) : not_found
    end

    def find_all
      objects = object_type.where(find_params)

      !objects.empty? ? respond_with(objects) : not_found
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

    def not_found
      render plain: "#{object_type} not found.", status: 404
    end
end
