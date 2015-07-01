class Comment
  include Mongoid::Document
  include Mongoid::Enum
  include Scopable

  # == Pagination, max per page
  paginates_per 10

  belongs_to :author, class_name: "User", inverse_of: :comments
  belongs_to :pitch_card, inverse_of: :comments, class_name: "PitchCard"

  field :comment,        type: String

  # is it a root (top-level) or is it a descendant
  enum :message_type, [:root, :descendant]

  # == Cyclic relationship
  has_many :child, :class_name => 'Comment', :inverse_of => :parent
  belongs_to :parent, :class_name => 'Comment', :inverse_of => :child

  # == Validation
  validates :author, presence: true
  validates :pitch_card, presence: true
  validates_length_of :comment, :maximum => DiscoursesHelper.comment_max_length, :allow_blank => false

  # == Denormalise
  field :author_name,        type: String

end
