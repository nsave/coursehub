class Course
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :duration, type: Float
  field :parent_id, default: nil
  field :like, type: Array

  validates :name, presence: true
  validates :description, presence: true

  belongs_to :user
  has_many :course_items
  has_many :course_progresses
  has_and_belongs_to_many :raw_tags, class_name: 'Tag'

  def tags
    raw_tags
  end

  def tags_names
    raw_tags.pluck(:name).join(' ')
  end

  def tags=(tags_names = [])
    tags_names.each do |tag_name|
      raw_tags << Tag.find_or_create_by(name: tag_name)
    end
    self.save
  end

  def fork(user_id)
    Course.create(user_id: user_id, duration: duration, parent_id: id,
                  description: description)
    course_items.each.fork(course_id)
  end

  def duration
    course_items.pluck(:duration).inject(0, :+)
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

  def like?(user)
    likes.include? user.id
  end

  def like(user_id)
    add_to_set likes: user_id
    save
  end

  def unlike(user_id)
    likes.delete user_id
    save
  end

  def progress_for_user(user)
    course_progresses.find_or_create_by(user_id: user.id)
  end
end
