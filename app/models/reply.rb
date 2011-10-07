class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :response, :presence => true
end
