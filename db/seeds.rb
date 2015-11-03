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
  model_type.transaction do
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
  end
  puts "Successfully loaded #{count} #{model_type.to_s}s into database!"
end

merchants_path  = "db/data/merchants.csv"
model_type = Merchant
load_csv(merchants_path, model_type)

customers_path  = "db/data/customers.csv"
model_type = Customer
load_csv(customers_path, model_type)

items_path  = "db/data/items.csv"
model_type = Item
load_csv(items_path, model_type)

invoices_path  = "db/data/invoices.csv"
model_type = Invoice
load_csv(invoices_path, model_type)

transactions_path  = "db/data/transactions.csv"
model_type = Transaction
load_csv(transactions_path, model_type)

invoice_items_path  = "db/data/invoice_items.csv"
model_type = InvoiceItem
load_csv(invoice_items_path, model_type)
