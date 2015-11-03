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

def random_objects_with_max(max, model_type)

  number_of_objects = Random.rand(1..max)
  objects = []
  number_of_objects.times do |index|
    objects[index] = create(model_type)
  end
  objects
end

def test_basic_endpoints(model_type=nil)
  describe "#index action for #{model_type}" do
    it "exists" do
      get :index, format: :json

      expect(response.status).to eq(200)
    end

    it "gets an index of all #{model_type}s" do
      objects = random_objects_with_max(30, model_type)

      get :index, format: :json

      expect(json.count).to eq(objects.count)
    end
  end

  context "#show action for #{model_type}" do
    it "gets an #{model_type}" do
      objects = random_objects_with_max(30, model_type)

      get :show, format: :json, id: objects.sample.id

      expect(response.status).to eq(200)
    end

    it "displays only one item" do
      objects = random_objects_with_max(30, model_type)

      get :show, format: :json, id: objects.sample.id

      expect(json.count).to eq(model_type.column_names.count)
    end

    it "returns 404 when the #{model_type} is not found" do
      objects = random_objects_with_max(30, model_type)

      get :show, format: :json, id: 9999999

      expect(response.status).to eq(404)
      expect(response.body).to include("not found")
    end
  end
end
