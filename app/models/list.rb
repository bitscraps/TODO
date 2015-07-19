class List < ActiveRecord::Base
  belongs_to :user

  scope :unarchived, -> { where(archived: false) }

  validates_presence_of :name
end
