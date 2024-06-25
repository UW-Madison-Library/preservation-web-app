# Preservation Web App
This repository is archived and will not be updated.

An administrative application that allows users to submit and review content for the [Preservation Service](https://github.com/UW-Madison-Library/preservation-service).

## System Dependencies
* Ruby 3.1.2 ([RVM recommended](https://rvm.io/))
* Foreman 0.88.1 (Install as a gem within RVM)

## Run
Follow the instructions to build and run the [Preservation Service Manager and Worker](https://github.com/UW-Madison-Library/preservation-service?tab=readme-ov-file#build). Both the preservation manager and preservation worker services need to be running for the webapp to function.

Clone this repository and then run `bundle install` to install the dependencies in the Gemfile.

Then run `./bin/dev` to start this Rails application.

The webapp can then be found at <http://localhost:3000>.

## Test Suite
Run `bundle exec rspec` to run the test suite.

Run `rubocop` to run the static code analyzer.

## User Details
The development and test environments use mock data for users. See [user.rb](app/models/user.rb) and [login_helper.rb](spec/support/login_helper.rb) for more information.

This distribution does NOT include a user authentication service. *User authentication is strongly recommended for production use.*

No remote S3 cloud service is configured by default.  Objects will get an error that replication failed to Glacier if no S3 storage is configured.  See [Preservation Service](https://github.com/UW-Madison-Library/preservation-service) for more information.
