class Album < ActiveRecord::Base
  attr_accessible :cover, :title, :user_id
  belongs_to :user

  mount_uploader :cover, CoverUploader

  validates :title, :presence => true, :uniqueness => true
  validates :cover, :presence => true
end