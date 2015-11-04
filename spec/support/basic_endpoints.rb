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

def random_attribute(object)
  object.attribute_names.sample.to_sym
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

    it "displays only one #{model_type}" do
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

  context "#find action for #{model_type}" do
    it "finds an #{model_type}" do
      objects = random_objects_with_max(30, model_type)
      object = objects.sample
      attribute = random_attribute(object)
      value = object.attributes[attribute.to_s]

      get :find, format: :json, id: objects.sample.id
      expect(response.status).to eq(200)

      get :find, format: :json, attribute => value
      expect(response.status).to eq(200)
    end

    it "displays only one #{model_type}" do
      objects = random_objects_with_max(30, model_type)
      object = objects.sample
      attribute = random_attribute(object)
      value = object.attributes[attribute.to_s]

      get :find, format: :json, attribute => value

      expect(json.count).to eq(model_type.column_names.count)
    end

    it "returns 404 when the #{model_type} is not found" do
      objects = random_objects_with_max(30, model_type)

      get :find, format: :json, id: 9999999

      expect(response.status).to eq(404)
      expect(response.body).to include("not found")
    end
  end

  context "#find_all action for #{model_type}" do
    it "finds multiple #{model_type}" do
      object1 =  create(model_type)
      begin
        attribute = random_attribute(object1)
      end while attribute == :id

      object2 = create(model_type, attribute => object1.attributes[attribute.to_s])
      object3 = create(model_type, attribute => object1.attributes[attribute.to_s])


      get :find_all, format: :json, attribute => object1.attributes[attribute.to_s]
      expect(response.status).to eq(200)

      get :find_all, format: :json, attribute => object1.attributes[attribute.to_s]
      expect(json.count).to eq(3)
    end

    it "returns 404 when no #{model_type} is not found" do
      objects = random_objects_with_max(30, model_type)

      get :find_all, format: :json, id: 9999999

      expect(response.status).to eq(404)
      expect(response.body).to include("not found")
    end
  end

  context "#random action for #{model_type}" do
    it "gives a random #{model_type}" do
      objects = random_objects_with_max(300, model_type)


      get :random, format: :json
      expect(response.status).to eq(200)

      get :random, format: :json
      first_response = json

      get :random, format: :json
      second_response = json

      expect(second_response).not_to eq(first_response)
    end
  end
end
