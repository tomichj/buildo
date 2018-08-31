# Buildo

Buildo is a collection of generators that jump-start building a Rails application. 

This is the first release of buildo. The auth generator, in particular, 
will evolve in the near term, once the next version of Oath 
(an authentication toolit) is released.

Buildo sets up Oath, Oath Generators, and Oath Lockdown for authentication, 
installs some scaffolding to set up authentication screens and controllers, 
adds a User model, and a collection of gems to assist in app development.

Buildo assumes you just built your app with Thoughtbot's 
[Suspenders](https://github.com/thoughtbot/suspenders). It's not strictly 
necessary, but buildo assumes some Suspenders-based conventions are in effect, 
e.g. that you have `app/views/application`.

Note: buildo generates a `User` model and migrations for you. If your user model will
be named something different, you'll have to manually migrate it after you run buildo.


## Installation

Add buildo to your Gemfile:

    gem 'buildo', group: :development

and `bundle install`.


## Generators

Buildo offers a number of generators. You can run any individual generator listed below,
or run them all (minus heroku) in one go with the `all` generator.


### App Base Generator

A collection of gems to assist in building your app.

    rails generate buildo:app_base

Installs:
* [operate](https://github.com/tomichj/operate) create service objects  
* [slim-rails](https://github.com/slim-template/slim-rails) templates similar to HAML, but better 
* [aasm](https://github.com/aasm/aasm) State machines for Ruby
* [reform](https://github.com/trailblazer/reform) form objects decoupled from models.
* [reform-rails](https://github.com/trailblazer/reform-rails) Automatically load and include all common Rails form features.
* [local_time](https://github.com/basecamp/local_time) Rails engine for cache-friendly, client-side local time


### Auth Generator

Installs:

* [oath](https://github.com/halogenandtoast/oath) rails authentication toolkit
* [oath-generators](https://github.com/halogenandtoast/oath-generators) generators for the oath authentication library
* [oath-lockdown](https://github.com/tomichj/oath-lockdown) An authentication system for Rails built on Oath.

Runs the oath generators scaffolding, which installs:
* a `User` model with email and password digest
* session and user controllers, routes, views to support sign up and sign in
* injects oath's helpers into application_controller.r
* a minimal config/oath/oath.en.yml

Buildo's scaffolding then replaces some of oath's scaffolding to support `remember me` and other Oath Lockdown features:
* session_controller.rb that supports `remember_me` and other oath-lockdown features
* sessions/new.html.erb that supports `remember_me`
* sign_in, sign_out, sign_up routes
* a partial for a header with sign_in, sign_out, sign_up links

To run this generator:

    rails generate buildo:auth

Run `rails db:migrate` after this. 


### Users Services

Installs:

* [User naming](https://github.com/tomichj/user_naming) naming methods for user models
* [User time zones](https://github.com/tomichj/user_time_zones) an easy way to work with multiple user time zones

To run this generator:

    rails generate buildo:users_services 

Both gems generate migrations. Run `rails db:migrate` after this.


### Heroku

You can create Heroku staging and production apps:

    rails generate heroku

This:

* Creates a staging and production Heroku app
* Sets them as `staging` and `production` Git remotes
* Creates a [Heroku Pipeline] for review apps
* Schedules automated backups for 10AM UTC for both `staging` and `production`

[Heroku Pipeline]: https://devcenter.heroku.com/articles/pipelines

You can optionally specify alternate Heroku flags:

    rails generate heroku \
      --heroku-flags "--region eu --addons sendgrid,ssl"

See all possible Heroku flags:

    heroku help create

The heroku generator is largely taken from the suspenders project's heroku adapter. Suspenders
does not offer the heroku setup as a generator, and can only be invoked during initial app 
generation. You can run buildo's heroku generator any time.


### All

Runs the `app_base`, `auth`, and `user_services` generators. Run `rails db:migrate` after this.

Note: The `all` generator does __not__ run heroku. Run that separately when you're ready.


## Issues

If you have problems, please create a [GitHub Issue](https://github.com/tomichj/buildo/issues).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tomichj/buildo. 

This project is intended to be a safe, welcoming space for collaboration, and 
contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) 
code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## Code of Conduct

Everyone interacting in the Buildo project’s codebases, issue trackers, chat rooms and mailing lists is 
expected to follow the [code of conduct](https://github.com/tomichj/buildo/blob/master/CODE_OF_CONDUCT.md).
