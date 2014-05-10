class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false
  
  validates :body, presence: true
  
  belongs_to :user
  belongs_to :post
  has_many :votes
end
