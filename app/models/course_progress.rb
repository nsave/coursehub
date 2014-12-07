class CourseProgress
  include Mongoid::Document

  belongs_to :course
  belongs_to :user
  embeds_many :item_progresses
end
