require 'rails_helper'

RSpec.describe Customer do 
  describe 'relationships' do 
    it { should have_many :items }
    it { should have_many(:items).through(:customer_items) }
  end
end