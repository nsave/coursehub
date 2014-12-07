class CourseItem
  include Mongoid::Document

  field :name, type: String
  field :url, type: String
  field :type, type: String # TODO: enum?
  field :duration, type: Float
  
  validates :name, presence: true
  validates :url, presence: true
  validates :type, presence: true
  validates :duration, presence: true, numericality: {greater_than: 0}

  belongs_to :course
  belongs_to :pull_request

  default_scope ->{ asc(:id) }

  def fork(course_id)
    CourseItem.create(name: name, url: url, type: type, course_id: course_id, duration: duration)
  end
end
