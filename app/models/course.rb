class Course
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :duration, type: Float
  field :parent_id, default: nil

  belongs_to :user
  has_many :course_items, dependent: :destroy
end
