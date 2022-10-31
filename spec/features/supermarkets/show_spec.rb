require 'rails_helper'

RSpec.describe 'the Supermarket show page' do 
  before(:each) do 
    @mike = Customer.create!(name: 'Michael Myers')
    @freddie = Customer.create!(name: 'Freddie Krueger')
    @it = Customer.create!(name: 'Pennywise')

    @market1 = Supermarket.create!(name: 'Halloweentown Grocers', location: '666 Hell Ct')

    @wing = @market1.items.create!(name: 'Bat Wing', price: 3)
    @eye = @market1.items.create!(name: 'Salamander Eye', price: 4)

    @mike.items << @wing
    @freddie.items << @eye 

    visit "/supermarkets/#{@market1.id}"
  end

  it 'shows a list of all customers that have shopped at this market' do
    expect(page).to have_content(@mike.name)
    expect(page).to have_content(@freddie.name)
    expect(page).to_not have_content(@it.name)

    @it.items << @wing
    visit "/supermarkets/#{@market1.id}"

    expect(page).to have_content(@it.name)
    save_and_open_page
  end
end