require 'rails_helper'

RSpec.describe 'the customer show page' do 
  before(:each) do 
    @mike = Customer.create!(name: 'Michael Myers')
    @market1 = Supermarket.create!(name: 'Halloweentown Grocers', location: '666 Hell Ct')
    @market2 = Supermarket.create!(name: 'Blood Market', location: '666 Hell Ave')
    @wing = @market1.items.create!(name: 'Bat Wing', price: 3)
    @eye = @market1.items.create!(name: 'Salamander Eye', price: 4)
    @pumpkin = @market2.items.create!(name: 'Pumpkin', price: 1)

    @mike.items << @wing << @pumpkin
    
    visit "/customers/#{@mike.id}"
  end

  it 'shows customer name and list of items with attributes' do 
    expect(page).to have_content('Michael Myers')

    within "#item-#{@wing.id}" do 
      expect(page).to have_content(@wing.name)
      expect(page).to have_content("Price: #{@wing.price}")
      expect(page).to have_content("Market: #{@wing.supermarket.name}")
    end

    within "#item-#{@pumpkin.id}" do 
      expect(page).to have_content(@pumpkin.name)
      expect(page).to have_content("Price: #{@pumpkin.price}")
      expect(page).to have_content("Market: #{@pumpkin.supermarket.name}")
    end
  end

  it 'has a form to add an item by id number' do
    expect(page).to_not have_content(@eye.name)

    fill_in 'Item ID', with: @eye.id
    click_button 'Add Item'

    expect(current_path).to eq("/customers/#{@mike.id}")
    expect(page).to have_content(@eye.name)

    save_and_open_page
  end
end