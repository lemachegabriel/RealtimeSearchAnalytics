require 'rails_helper'

RSpec.describe SearchProcessorJob, type: :job do
  let(:user_id) { 'user_12345' }
  let(:search_term) { 'test' }
  let(:ip) { '127.0.0.1' }
  let(:redis_key) { "user:#{user_id}:searches" }

  before do
    allow($redis).to receive(:lrange).and_return([search_term])
    allow($redis).to receive(:del)
  end

  it 'fetches the searches from Redis' do
    described_class.perform_now(user_id, search_term, ip)
    expect($redis).to have_received(:lrange).with(redis_key, 0, -1)
  end

  it 'deletes the Redis key after fetching searches' do
    described_class.perform_now(user_id, search_term, ip)
    expect($redis).to have_received(:del).with(redis_key)
  end

  context 'when there are searches' do
    it 'creates a new Search record with the last search term' do
      expect {
        described_class.perform_now(user_id, search_term, ip)
      }.to change(Search, :count).by(1)
      search = Search.last
      expect(search.term).to eq(search_term)
      expect(search.ip).to eq(ip)
      expect(search.user_id).to eq(user_id)
    end
  end

  context 'when there are no searches' do
    before do
      allow($redis).to receive(:lrange).and_return([])
    end

    it 'does not create a new Search record' do
      expect {
        described_class.perform_now(user_id, search_term, ip)
      }.not_to change(Search, :count)
    end
  end
end
