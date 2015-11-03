class Api::V1::BaseApiController < ApplicationController
    respond_to :json
    def index
      respond_with object_type.all
    end
end
