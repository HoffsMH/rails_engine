require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  it "gets an index of all items" do
    # get "api/v1/items"
    get :index, format: :json

    expect(response.status).to eq(200)
  end

end
