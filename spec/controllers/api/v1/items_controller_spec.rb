require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  it "does something" do
    # get "api/v1/items"
    get :index, format: :json
    
    expect(response)
  end

end
