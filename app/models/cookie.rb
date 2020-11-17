class Cookie < ActiveRecord::Base
  attr_accessor :amount
  belongs_to :storage, polymorphic: :true
  after_create :cooking_job

  validates :storage, presence: true

  def ready?
    cooked
  end

  def cooking_job
    CookingJob.set(wait: 5.seconds).perform_now self
  end
end
