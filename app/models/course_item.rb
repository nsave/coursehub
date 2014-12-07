class CourseItem
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :url, type: String
  field :type, type: String # TODO: enum?

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true
  validates :type, presence: true

  belongs_to :course
  has_one :item_progress

  def learn
    item_progress.learn
  end

  def unlearn
    item_progress.unlearn
  end

  def learned?
    item_progress.learned
  end

  def fork(course_id)
    ci = CourseItem.create(name: name, description: description, url: url,
                           type: type, course_id: course_id)
    ItemProgress.create(learned: false, course_item_id: ci.id,
                        course_id: course_id)
    ci
  end
end
