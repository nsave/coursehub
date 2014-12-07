class CourseProgress
  include Mongoid::Document

  belongs_to :course # for each user we fork course
  embeds_many :item_progresses
end
