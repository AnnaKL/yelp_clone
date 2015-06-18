class Restaurant < ActiveRecord::Base

  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  # def build_review(current_user, review_params)
  #      # review_params[:user_id] = current_user
  #      byebug
  # end
end
