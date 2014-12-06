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
end
