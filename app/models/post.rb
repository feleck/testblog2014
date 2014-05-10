class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates :body, presence: true
  validates :title, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope ->{ ne(archived: true) }

  def archive!
    update_attribute :archived, true
  end

  def hotness
    hotness = 3
    hours_ago = (Time.now - self.created_at) / 3600
    case hours_ago
    when (0..24)
      hotness = 3
    when (24..72)
      hotness = 2
    when (24*3..24*7)
      hotness = 1
     else
      hotness = 0
    end
    hotness += 1 if comments.count >= 3
    hotness
  end
end
