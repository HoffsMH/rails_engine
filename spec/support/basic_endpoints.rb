################################################
# we need to test that a basic action returns
################################################
  # status code 200 when called correctly
  # the right amount of objects/ the right object
  # null when no items
  #
  # error code if applicable under certain conditions
  # error message if applicable under certain conditions
  #
  # We do NOT test that we get the right type of objects
  # or that the response will have a certain structure
    # these test will change from endpoint to endpoint and
    # with time if we user serializers

def test_basic_endpoints(model_type=nil)
  describe "#index action for #{model_type}" do
    it "exists" do
      get :index, format: :json

      expect(response.status).to eq(200)
    end
    it "gets an index of all #{model_type}s" do
      obj = create(model_type)
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
