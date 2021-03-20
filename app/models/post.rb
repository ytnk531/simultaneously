class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :time, presence: true
end
