class ItemProgress
  include Mongoid::Document

  belongs_to :course
  embedded_in :course_progress

  field :learned, type: Boolean, default: false

  def learn
    update(learned: true)
  end

  def unlearn
    update(learned: false)
  end
end
