# Realtime Search Analytics

This project demonstrates a realtime search box for users to search articles, with an analytics feature that displays what users are searching for. The goal is to record user input in realtime and ultimately display analytics and trends on the most popular searches.

## Features

- **Realtime Search Logging:** Captures and records user searches in realtime.
- **Analytics:** Displays trends and analytics on what users are searching for.
- **Scalability:** Designed to handle thousands of requests per hour.
- **User Isolation:** Each user's search data is kept separate.
- **Rspec Tests:** Includes tests to ensure the robustness of the application.

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

