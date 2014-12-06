class Course
  include Mongoid::Document

  field :name, type: String
  field :description, type: String

  has_many :course_items
end
