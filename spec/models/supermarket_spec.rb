require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  before(:each) do 
    @mike = Customer.create!(name: 'Michael Myers')
    @freddie = Customer.create!(name: 'Freddie Krueger')
    @it = Customer.create!(name: 'Pennywise')

    @market1 = Supermarket.create!(name: 'Halloweentown Grocers', location: '666 Hell Ct')

    @wing = @market1.items.create!(name: 'Bat Wing', price: 3)
    @eye = @market1.items.create!(name: 'Salamander Eye', price: 4)

    @mike.items << @wing
    @freddie.items << @eye 
  end

  describe 'instance methods' do
    describe '#customers' do 
      it 'returns customers who have shopped at this market' do 
        expect(@market1.customers).to eq([@mike, @freddie])

        @it.items << @eye 

        expect(@market1.customers).to eq([@mike, @freddie, @it])
      end
    end
  end
end