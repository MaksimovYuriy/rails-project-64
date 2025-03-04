setup:
	bundle install
	yarn install
	yarn build
	yarn build:css
	rails db:migrate
	rails db:seed

lint:
	rake lint:all

tests:
	rake test