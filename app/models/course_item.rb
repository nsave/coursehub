class CourseItem
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :url, type: String
  field :type, type: String

  belongs_to :course
end
