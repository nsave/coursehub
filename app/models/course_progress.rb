class CourseProgress
  include Mongoid::Document

  belongs_to :course
  belongs_to :user
  field :items, type: Array, default: []

  def learned?(item)
    items.include?(item.id)
  end

  def learn(item)
    add_to_set(items: item.id)
  end

  def unlearn(item)
    pull(items: item.id)
  end
end
