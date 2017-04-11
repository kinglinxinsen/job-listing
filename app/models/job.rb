class Job < ApplicationRecord
  validates :title, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0}
  scope :published, -> { where(is_hidden: false) }
  def publish!
    self.is_hidden = false
    self.save
  end
  def hide!
    self.is_hidden = true
    self.save
  end
def index
  @jobs = case params[:order]
  when 'by_lower_bound'
    Job.published.order('wage_lower_bound DESC')
  when 'by_upper_bound'
    Job.published.order('wage_upper_bound DESC')
  else
    Job.published.recent
  end
end

end
