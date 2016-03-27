class Comment < ActiveRecord::Base

  validates_presence_of :comment

  belongs_to :user
  belongs_to :po

  after_commit :update_po_time

  def update_po_time
    self.po.update(updated_at: Time.now)
  end

end
