namespace :lint do
  desc 'Run slim-lint'
  task :slim do
    puts 'Running slim-lint...'
    sh('bundle exec slim-lint app/views/**/*.slim')
  end

  desc 'Run rubocop-rails'
  task :rubocop do
    puts 'Running rubocop-rails...'
    sh('bundle exec rubocop --plugin rubocop-rails')
  end

  desc 'Run (slim && rubocop) lints'
  task all: [:slim, :rubocop]
end