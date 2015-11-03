require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  context "#index action" do
    it "gets an index" do
      get :index, format: :json

      expect(response.status).to eq(200)
    end

    it "gets an index of all items" do
      merchant = Merchant.create(name: "some_merchant_name")
      Item.create(name: "some_item_name", merchant_id: merchant.id)
      get :index, format: :json

      json_response = JSON.parse(response.body)
      number_of_items = Item.all.count

      expect(json_response.count).to eq(number_of_items)
    end
  end

  context "#show action" do
    it "gets an item" do
      get :show, format: :json, id: 1

      expect(response.status).to eq(200)
    end

    it "displays the item" do
      merchant = Merchant.create(name: "some_merchant_name")
      item = Item.create(name: "some_item_name", merchant_id: merchant.id)
      get :show, format: :json, id: item.id

      json_response = JSON.parse(response.body)

      expect(json_response.count).to eq(Item.column_names.count)
    end

    it "shows information for the item" do
      merchant = Merchant.create(name: "some_merchant_name")
      item = Item.create(name: "some_item_name", merchant_id: merchant.id, description: "blah blah")
      get :show, format: :json, id: item.id

      json_response = JSON.parse(response.body)

      expect(json_response["name"]).to eq(item.name)
      expect(json_response["description"]).to eq(item.description)
    end
  end

end
