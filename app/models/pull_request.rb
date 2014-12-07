class PullRequest
  include Mongoid::Document

  belongs_to :user
  belongs_to :course

  auto_increment :id
  belongs_to :course
  has_many :course_items
end
