class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks

  scope :unarchived, -> { where(archived: false) }

  validates_presence_of :name
end
