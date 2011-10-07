class User < ActiveRecord::Base
  has_many :posts
  has_many :votes
  has_many :replies
  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true,
                       :length       => { :within => 6..40 }
  validates :email, :presence => true

  end
