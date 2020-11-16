class CookingJob < ApplicationJob
  queue_as :default

  def perform(cookie)
    cookie.cooked = true
    cookie.save!
  end
end
