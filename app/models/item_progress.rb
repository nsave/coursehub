class ItemProgress
  include Mongoid::Document

  field :learned, type: Boolean, default: false

  def learn
    update(learned: true)
  end

  def unlearn
    update(learned: false)
  end
end
