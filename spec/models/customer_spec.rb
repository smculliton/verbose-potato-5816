require 'rails_helper'

RSpec.describe Customer do 
  describe 'relationships' do 
    it { should have_many :items }
    it { should have_many(:items).through(:customer_items) }
  end

  before(:each) do 
    @mike = Customer.create!(name: 'Michael Myers')
    @market1 = Supermarket.create!(name: 'Halloweentown Grocers', location: '666 Hell Ct')
    @wing = @market1.items.create!(name: 'Bat Wing', price: 3)
    @eye = @market1.items.create!(name: 'Salamander Eye', price: 4)
  end

  describe 'instance methods' do 
    describe '#add_item' do 
      it 'adds an item by an id number' do 
        @mike.add_item(@wing.id)

        expect(@mike.items).to eq([@wing])

        @mike.add_item(@eye.id)

        expect(@mike.items).to eq([@wing, @eye])
      end
    end
  end
end