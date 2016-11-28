class Comment < ApplicationRecord
  belongs_to :article
  #validates :comment, presents: true, length: { minimum: 5 }
end
