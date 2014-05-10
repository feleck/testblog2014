class Vote
  include Mongoid::Document
  include Mongoid::Timestamps
  
  after_create :mark_abusive

  field :value, type: Integer, default: 0

  belongs_to :user
  belongs_to :comment

  protected 
  def mark_abusive
   comment.update_attribute :abusive, true if comment.votes.where(value: -1).count >= 3
  end
end
