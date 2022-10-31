class Supermarket < ApplicationRecord
  has_many :items

  def customers
    Customer.where(id: CustomerItem.where(item_id: items.pluck(:id)).pluck(:customer_id))
  end
end