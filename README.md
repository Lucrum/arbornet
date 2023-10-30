# Arbornet

This project is from The Odin Project's Ruby on Rails [curriculum](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project).

A social networking web app running on Ruby on Rails.

# usage

1. To run, download this repository and navigate into the folder. Run `bundle install` to install any necessary gems. On top of the base gems Rails includes, Arbornet uses gems such as `devise` and `shoulda` for user authentication and basic integration tests.

2. Optionally run `rake db:seed` to seed the database with a few users.

3. Finally, run `bin/rails s` and head to http://127.0.0.1:3000.

# features

Users must create an account to interact with the app.

Users can post text or images, which can be liked or commented on.

Users can send friend requests to other users, which can be accepted or ignored.

OmniAuth for simple sign up and sign ins

Email notifications for sign ups

# planned features

An actual UI