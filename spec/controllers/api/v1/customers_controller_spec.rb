require 'rails_helper'
require 'support/basic_endpoints'

RSpec.describe Api::V1::CustomersController, type: :controller do
  test_basic_endpoints(Customer)
end
