# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'rubygems'
require 'csv'

def load_csv(file_path, model_type)
  args = {:headers => true,
              :header_converters => :symbol,
              :converters => :all}
  count = 0

  CSV.foreach(file_path, args) do |row|
    record = model_type.new()
    row.headers.each_with_index do |header, index|
      if header != :id
        record.update(header => row[index])
      end
    end
    count += 1
    print '.' if (count % 10) == 0
  end
  puts "Successfully loaded #{count} records into database!"
end

merchants_path  = "db/data/merchants.csv"
model_type = Merchant
load_csv(merchants_path, model_type)
