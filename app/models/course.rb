class Course
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :duration, type: Float
  field :parent_id, default: nil

  validates :name, presence: true
  validates :description, presence: true
  validates :duration, presence: true, numericality: {greater_than: 0}

  belongs_to :user
  has_many :course_items, dependent: :destroy

  def fork(user_id)
    Course.create(user_id: user_id, duration: duration, parent_id: id,
                  description: description, course_items: course_items)
  end

  def pull_request
    merged_already = parent.course_items.where(user_id: id)
    items = course_items.where(user_id: id) - merged_already
    parent.suggested_items += items
    parent.update
  end

  def parent
    Course.find parent_id
  end
end
