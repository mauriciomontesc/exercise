require 'rails_helper'

describe CookingJob, type: :job do
  describe '#perform_later' do
    ActiveJob::Base.queue_adapter = :test
    let(:cookie) { FactoryGirl.create(:cookie) }
    subject(:job) { described_class.set(wait: 5.seconds).perform_later(cookie) }

    it 'queues the job' do
      expect { job }
        .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'cooking' do
      expect {
        described_class.set(wait: 5.seconds).perform_later(cookie)
      }.to have_enqueued_job.with(cookie)
    end

    it 'cooked' do
      expect {
        described_class.perform_now(cookie)
      }.to change(cookie, :cooked).from(false).to(true)
    end
  end
end
