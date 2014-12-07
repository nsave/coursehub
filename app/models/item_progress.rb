class ItemProgress
  include Mongoid::Document

  belongs_to :course
  belongs_to :course_item

  field :learned, type: Boolean, default: false

  def learn
    update(learned: true)
  end

  def unlearn
    update(learned: false)
  end
end
