require 'rails_helper'

RSpec.describe CustomerItem do 
  describe 'relationships' do 
    it { should belong_to :customer }
    it { should belong_to :item }
  end
end