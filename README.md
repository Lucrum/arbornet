# Arbornet

This project is from The Odin Project's Ruby on Rails [curriculum](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project).

A social networking web app running on Ruby on Rails, like Facebook.

# Features

Users must create an account to interact with the app.

Users can post text or images, which can be liked or commented on.

Users can send friend requests to other users, which can be accepted or ignored.

OmniAuth for simple sign up and sign ins

Email notifications for sign ups

Turbo Stream implementation for Single Page Application-esque likes

# Usage

1. To run, download this repository and navigate into the folder. Run `bundle install` to install any necessary gems. On top of the base gems Rails includes, Arbornet uses gems such as `devise` and `shoulda` for user authentication and basic integration tests.

2. Optionally run `rake db:seed` to seed the database with a few users.

3. Finally, run `bin/rails s` and head to http://127.0.0.1:3000.

Note: OmniAuth with Google is configured with `Figaro`. As a result, if you wish to sign in with Google, you'll need to get your own API key at https://code.google.com/apis/console/. Note the client ID and client secret.

Run `bundle exec figaro install`, which will generate `config/application.yml`, then add the following lines to the file:

```ruby
GOOGLE_CLIENT_ID: "<YOUR GOOGLE CLIENT ID>"
GOOGLE_CLIENT_SECRET: "<YOUR GOOGLE CLIENT SECRET>"
```

Replace the contents of the quotes with your client ID and secret.

Arbornet will still run without this configuration, but Google sign in will be broken.

# Reflections

This project was my largest yet, putting nearly all the knowledge I've learned so far in my web development journey to the test. I've learned a lot, both in terms of new concepts and reinforcing old ones, and it's definitely had its ups and downs.

Arbornet seemed pretty daunting when I first started on it. A *Facebook* clone?! Where do I even begin? Breaking things down into smaller and smaller problems made it much easier to focus my attention. Users, friendships, posts, likes.

If nothing else, Arbornet has taught me the importance of planning early, and planning well. I've rewritten a few things several times, from badly designed systems (friendships & friend requests) to updating things to reflect my new found knowledge (polymorphic paths). Many things that appeared to be intimidating at first (OmniAuth integration, mostly) weren't nearly as bad once I got down to it. I didn't really plan too much, but I didn't expect the project to become so massive.

When I first started working with Ruby on Rails, I found its structure, both filing and namespacing, to be cumbersome and tedious. However, its insistence on organization made things much easier to find as Arbornet grew in features, and so did my appreciation for it. Additionally, I found myself appreciating the software development process I used during my senior capstone project. The structure and overhead was a bit claustrophobic but lent purpose and clarity as to what I needed to do and how to accomplish it. While I can manage smaller, solo projects like this with minimal organization, git branches, documentation, and all the other tools are probably things I'd want to start using going forward if I'm working with others.

There's still a good bit of polish left to do on Arbornet. Niceties like prettying up the Google Sign In button, or certain forms.

Deployment would be nice, but Heroku no longer has a free tier, so you'll have to settle for either running on your local machines or these screenshots.

# Screenshots
Timeline
![Timeline](https://user-images.githubusercontent.com/28992495/279777007-e11cf0fd-fde9-40ae-b1d4-f0575e0e885f.png)

Single Post
![Post View](https://user-images.githubusercontent.com/28992495/279777332-f1adb830-0a9c-44f4-85fa-ddfda756e9f4.png)

User's Profile
![Profile View](https://user-images.githubusercontent.com/28992495/279777492-8385c899-2bf4-423f-a45d-6a44ef76a986.png)

Users
![Users View](https://user-images.githubusercontent.com/28992495/279777420-50130b12-aaa0-4fa9-a4cc-3968ef538e04.png)

# Gems

- [`Devise`](https://github.com/heartcombo/devise) - User authentication and secure pasword management
- [`Figaro`](https://github.com/laserlemon/figaro) - Google OmniAuth configuration
- [`Google OmniAuth OAuth2`](https://github.com/zquestz/omniauth-google-oauth2) - Google Sign In
- [`Guard`](https://github.com/guard/guard) - Persistent integration testing
- [`Letter Opener`](https://github.com/ryanb/letter_opener) - Email previews in testing
- [`Shoulda`](https://github.com/thoughtbot/shoulda) - Simple integration tests

# Planned features

- Further polish

- Deployment!

# Limitations

- Photos may not be added or removed when editing a post.