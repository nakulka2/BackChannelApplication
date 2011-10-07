class Post < ActiveRecord::Base
  belongs_to :user
  has_many :replies
  validates :question, :presence => true
end
