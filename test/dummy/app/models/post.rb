class Post < ApplicationRecord
  belongs_to :person

  scope :visible, -> { where(private: false) }
end
