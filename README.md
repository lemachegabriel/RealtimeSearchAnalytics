# Realtime Search Analytics

This project demonstrates a realtime search box for users to search articles, with an analytics feature that displays what users are searching for. The goal is to record user input in realtime and ultimately display analytics and trends on the most popular searches.

## Features

- **Realtime Search Logging:** Captures and records user searches in realtime.
- **Analytics:** Displays trends and analytics on what users are searching for.
- **Scalability:** Designed to handle thousands of requests per hour.
- **User Isolation:** Each user's search data is kept separate.
- **Rspec Tests:** Includes tests to ensure the robustness of the application.

## How It Works

### Real-time Search Logging

1. **User Input Capture:** As a user types into the search box, each keystroke triggers a JavaScript event that sends the current search term to the server via an POST request.
2. **Debounce Mechanism:** A debounce function is implemented to limit the number of requests sent to the server, reducing unnecessary load and preventing excessive logging of incomplete search terms.
3. **Temporary Storage in Redis:** Each partial search term is stored in a Redis list unique to the user. Redis is chosen for its high performance and ability to handle a large volume of operations per second.
4. **Delayed Processing:** After a short delay, a Sidekiq job (`SearchProcessorJob`) is enqueued to process the search terms stored in Redis.
5. **Consolidation of Search Terms:** The `SearchProcessorJob` retrieves the list of search terms from Redis, discards incomplete terms, and saves only the final, complete search term to the database. This step ensures that only meaningful search queries are logged, avoiding the pyramid problem where intermediate, incomplete searches clutter the data.

### Analytics

- **Search Data Aggregation:** The saved search terms are periodically aggregated to generate analytics, providing insights into what users are searching for most frequently. This data is accessible on the `Admin Panel` route `/admin` or on production (https://real-time-search-analytics-1b75562e254e.herokuapp.com/admin/search) .

By combining Redis for fast, temporary storage and Sidekiq for efficient, reliable background processing, we achieve a scalable and responsive system for capturing and analyzing real-time search data.

## Requirements

- Ruby 3.1.4+
- Rails 7.0.8+
- Redis
- Sidekiq

## Setup

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/lemachegabriel/RealtimeSearchAnalytics
   cd RealtimeSearchAnalytics

2. **Install Dependencies:**
    ```bash
    bundle install

3. **Set up the database and precompile:**
   ```bash
    rails db:create
    rails db:migrate
    rails assets:precompile

4. **Start Redis:**
   ```bash
   redis-server

5. **Start Sidekiq:**
   ```bash
   bundle exec sidekiq

6. **Start the Rails server:**
   ```bash
   rails s
## Testing

**RSpec is used for testing the application. To run the tests, use:**
```bash
bundle exec rspec

