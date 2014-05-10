class Vote
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :value, type: Integer, default: 0

  belongs_to :user
  belongs_to :comment

end
