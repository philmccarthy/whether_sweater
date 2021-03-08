require 'rails_helper'

RSpec.describe Munchie do
  describe 'instantiation' do
    it 'exists and has proper attributes' do
      munchie = Munchie.new({
        :destination_city=>"seattle,wa",
        :travel_time=>"18:24:27",
        :forecast=>{
          :summary=>"few clouds",
          :temperature=>"38"},
        :restaurant=> {
          :name=>"Sushi Joa",
          :address=>"2717 78th Ave SE, Mercer Island, WA 98040",
        }
      })

      expect(munchie.destination_city).to eq('Seattle, Wa')
      expect(munchie.travel_time).to eq('18:24:27')
      expect(munchie.forecast).to eq({summary: 'few clouds', temperature: "38"})
      expect(munchie.restaurant).to eq({name: 'Sushi Joa', address: "2717 78th Ave SE, Mercer Island, WA 98040"})
    end
  end
end
