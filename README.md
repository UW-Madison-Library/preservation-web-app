# Preservation Web App
This repository is archived and will not be updated.

An administrative application that allows users to submit and review content for the [Preservation Service](https://github.com/UW-Madison-Library/preservation-service).

## System Dependencies
* Ruby 3.1.2 ([RVM recommended](https://rvm.io/))

## Development
Follow the instructions to build and run the [Preservation Service Manager and Worker](https://github.com/UW-Madison-Library/preservation-service?tab=readme-ov-file#build).

Clone this repository and then run `bundle install` to install the dependencies in the Gemfile.

Then run `./bin/dev` to start this Rails application.

## Test Suite
Run `bundle exec rspec` to run the test suite. [Rspec method stubs](https://github.com/rspec/rspec-mocks#method-stubs) are used to replace calls to the Preservation Manager.

Run `rubocop` to run the static code analyzer.

## User Details
The development and test environments use mock data for users. See [user.rb](app/models/user.rb) and [login_helper.rb](spec/support/login_helper.rb) for more information.

This distribution does NOT include a user authentication service. *User authentication is strongly recommended for production use.*
