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
  has_many :course_items
  has_many :course_progresses

  def fork(user_id)
    Course.create(user_id: user_id, duration: duration, parent_id: id,
                  description: description)
    course_items.each.fork(course_id)
  end

  def pull_request
    pr = PullRequest.create(course_id: parent_id)
    merged_already = parent.course_items.where(user_id: id).map(&:url)
    items = course_items.where(user_id: id)
      .reject { |x| merged_already.include? x[:url] }
      .map { |x| x.fork parent_id }
      .map { |x| x.update(pull_request: pr) }
  end

  def merge_request(request_id)
    items = PullRequest.find(request_id).course_items
    items.update_all(pull_request_id: nil, course_id: id)
  end

  def progress
    ip = item_progresses
    ip.where(learned.true).size / ip.size
  end

  def parent
    Course.find parent_id
  end
end
