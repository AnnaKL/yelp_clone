require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }


  it 'is not valid with a name of less than three characters' do
  restaurant = Restaurant.new(name: "kf")
  expect(restaurant).not_to be_valid
  end
end

describe '#average_rating' do
  context ' no reviews' do
    it 'returns "N/A when there are no reviews' do
      restaurant = Restaurant.create(name: 'The Ivy')
      expect(restaurant.average_rating).to eq 'N/A'
    end
  end

  context '1 review' do
    it 'returns that rating' do
      restaurant = Restaurant.create(name: 'The Ivy')
      restaurant.reviews.create(rating: 4)
      expect(restaurant.average_rating).to eq 4
    end
  end

  context 'multiple reviews' do

   let(:user1) {User.create(email: 'test@test.com', password: '11111111')}
   let(:user2) {User.create(email: 'bob@bob.com', password: '22222222')}


    it 'returns the average' do
      restaurant = Restaurant.create(name: 'The Ivy')
      restaurant.reviews.create(user: user1, rating: 1)
      restaurant.reviews.create(user: user2, rating: 5)
      expect(restaurant.average_rating).to eq 3
    end
  end
end