# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'database_cleaner'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'
require 'bunny-mock'
require 'elasticsearch/model'
require 'elasticsearch/persistence'
require "sidekiq/testing"

BunnyMock::use_bunny_queue_pop_api = true
WebMock.disable_net_connect!(allow_localhost: true)

unless defined?(ELASTICSEARCH_URL)
  ELASTICSEARCH_URL = ENV['ELASTICSEARCH_URL'] || "localhost:#{(ENV['TEST_CLUSTER_PORT'] || 9200)}"
end
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # add `FactoryBot` methods
  config.include FactoryBot::Syntax::Methods
  config.include JSONResponseReader, type: :request
  config.include AuthorizationRequestStubber, type: :request
  #config.include HerStubber
  config.include ElasticModelStubber

  # start by truncating all the tables but then use the faster transaction strategy the rest of the time.
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction

    # reindex models
    Feed.reindex
    JanjiPolitik.reindex
    Question.reindex
    Quiz.reindex

    # and disable callbacks
    Searchkick.disable_callbacks

    Publishers::ApplicationPublisher.connection = BunnyMock.new.start
  end

  config.around(:each, search: true) do |example|
    Searchkick.callbacks(true) do
      example.run
    end
  end

  config.before(:each, search: true) do |example|
  end

  config.before type: :request do
    BannerInfo.create!([
                         { id: "ade8d637-e85e-4726-8005-6cede80ea860", page_name: "pilpres", title: "Judul banner pilpres", body: "Body banner pilpres" },
                         { id: "5d01f7ab-4c90-4199-999b-da5287d06a88", page_name: "janji politik", title: "Judul banner 'janji politik'", body: "Body banner 'janji politik'" },
                         { id: "a22d2acd-7eda-4a7a-95a0-931abf5db8e3", page_name: "tanya", title: "Judul banner tanya", body: "Body banner tanya" },
                         { id: "9b98ac07-3208-4d60-976e-49ace39e38a7", page_name: "kuis", title: "Judul banner kuis", body: "Body banner kuis" },
                       ])
    Kenalan.create!([
                      { id: "c46bae56-8c87-4f54-8328-b959d89c931f", text: 'Melakukan Verifikasi' },
                      { id: "9bbc974c-dab4-4467-ac5f-84e8a8d56b1c", text: 'Lengkapi Biodata' },
                      { id: "c3fded37-5b4b-4a81-aee7-ee24d845b5e8", text: 'Lengkapi Data Lapor' },
                      { id: "231cbadc-a856-4723-93a9-bb79915dd40d", text: 'Tanya Presiden' },
                      { id: "f2596bdb-90ba-41e9-8c39-11c891c68f1f", text: 'Ikuti Quiz' },
                      { id: "e27b16e8-f585-448b-afbc-0219c48471d6", text: 'Kunjungi Janji Politik' },
                      { id: "16fc11b3-c5a4-491c-81f4-cd6cdca1ed1e", text: 'Ikuti Word Stadium' },
                      { id: "2022ad13-d602-4eba-9cf1-9ef2ea0e158d", text: 'Kontribusi Lapor' },
                      { id: "8706f239-09ad-47b3-b8bb-a3a37439c519", text: 'Kontribusi Perhitungan' },
                      { id: "6c5ffd3d-219a-43e0-8035-c71af1459658", text: 'Baca Pantau Bersama' }
                    ])
  end
  config.after(:all) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
      delete_all_indices!
    end
  end
end

# configure shoulda matchers to use rspec as the test framework and full matcher libraries for rails
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def random_quiz(count = 1)
  @quiz = create :quiz
  @quiz.published!

  [*1..count].each do |i|
    question = create :quiz_question, quiz: @quiz
    create :quiz_answer_team_1, quiz_question: question
    create :quiz_answer_team_2, quiz_question: question
  end
end

def answer_quiz(user_id, quiz)
  quiz_participation = quiz.participate! user_id
  quiz.quiz_questions.each do |qq|
    QuizAnswering.create! user_id:          user_id, quiz_participation: quiz_participation, quiz: qq.quiz,
                          quiz_question_id: qq.id, quiz_answer_id: qq.quiz_answers.last.id
  end
end
def delete_all_indices!
  client = Elasticsearch::Model.client
  ActiveRecord::Base.descendants.each do |model|
    begin
      client.indices.delete(index: model.index_name) if model.__elasticsearch__.index_exists?
    rescue
    end
  end and true
end

RSpec::Sidekiq.configure do |config|
  # Clears all job queues before each example
  config.clear_all_enqueued_jobs = true # default => true

  # Whether to use terminal colours when outputting messages
  config.enable_terminal_colours = true # default => true

  # Warn when jobs are not enqueued to Redis but to a job array
  config.warn_when_jobs_not_processed_by_sidekiq = true # default => true
end
