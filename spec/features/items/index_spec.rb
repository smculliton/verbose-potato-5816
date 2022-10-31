require 'rails_helper'

RSpec.describe 'the Item index page' do 
  before(:each) do 
    @mike = Customer.create!(name: 'Michael Myers')
    @freddie = Customer.create!(name: 'Freddie Krueger')

    @market1 = Supermarket.create!(name: 'Halloweentown Grocers', location: '666 Hell Ct')
    @market2 = Supermarket.create!(name: 'Blood Market', location: '666 Hell Ave')

    @wing = @market1.items.create!(name: 'Bat Wing', price: 3)
    @eye = @market1.items.create!(name: 'Salamander Eye', price: 4)
    @pumpkin = @market2.items.create!(name: 'Pumpkin', price: 1)

    visit '/items'
  end

  it 'lists all items name price and supermarket' do 
    within "#item-#{@wing.id}" do 
      expect(page).to have_content(@wing.name)
      expect(page).to have_content("Price: #{@wing.price}")
      expect(page).to have_content("Market: #{@wing.supermarket.name}")
    end

    within "#item-#{@eye.id}" do 
      expect(page).to have_content(@eye.name)
      expect(page).to have_content("Price: #{@eye.price}")
      expect(page).to have_content("Market: #{@eye.supermarket.name}")
    end

    within "#item-#{@pumpkin.id}" do 
      expect(page).to have_content(@pumpkin.name)
      expect(page).to have_content("Price: #{@pumpkin.price}")
      expect(page).to have_content("Market: #{@pumpkin.supermarket.name}")
    end
  end

  it 'shows count of customers that bought each item' do 
    within "#item-#{@wing.id}" do 
      expect(page).to have_content('Number of Customers: 0')

      @mike.items << @wing
      visit '/items'
    
      expect(page).to have_content('Number of Customers: 1')

      @freddie.items << @wing
      visit '/items'

      expect(page).to have_content('Number of Customers: 2')
    end

    within "#item-#{@pumpkin.id}" do 
      expect(page).to have_content('Number of Customers: 0')
    end
  end
end