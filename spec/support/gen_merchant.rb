
def gen_merchants(count)
  dataset = {
    merchants: [],
    transactions: [],
    invoice_items: [],
    invoices: [],
    items: []
  }

  count.times do
    merchant = create(:merchant)
    dataset[:merchants] << merchant
    invoice = create(:invoice, merchant_id: merchant.id)
    dataset[:invoices] << invoice
    dataset[:transactions] << create(:transaction, invoice_id: invoice.id, result: "success")
    dataset[:invoice_items] << create(:invoice_item, invoice_id: invoice.id)
    dataset[:invoice_items] << create(:invoice_item, invoice_id: invoice.id)
    dataset[:invoice_items] << create(:invoice_item, invoice_id: invoice.id)
    dataset[:invoice_items] << create(:invoice_item, invoice_id: invoice.id)
  end
  dataset
end
