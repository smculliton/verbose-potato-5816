require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:customers).through(:customer_items) }
  end

  before(:each) do 
    @mike = Customer.create!(name: 'Michael Myers')
    @freddie = Customer.create!(name: 'Freddie Krueger')

    @market1 = Supermarket.create!(name: 'Halloweentown Grocers', location: '666 Hell Ct')

    @wing = @market1.items.create!(name: 'Bat Wing', price: 3)
    @eye = @market1.items.create!(name: 'Salamander Eye', price: 4)
  end

  describe 'instance methods' do
    describe '#customer_count' do 
      it 'returns number of customers who bought an item' do 
        expect(@wing.customer_count).to eq(0)
        
        @mike.items << @wing
        expect(@wing.customer_count).to eq(1)

        @freddie.items << @wing
        expect(@wing.customer_count).to eq(2)
        expect(@eye.customer_count).to eq(0)
      end
    end
  end
end
