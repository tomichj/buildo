# Buildo

Buildo is a small collection of generators that jump-start building a Rails application. 
This is the first release of buildo, and it doesn't do a ton yet.

Buildo sets up Oath and Oath Lockdown for authentication, installs some scaffolding to set up
authentication, adds a User model, and a collection of gems to assist in app development. 

Buildo assumes you just build your app with Thoughtbot's [Suspenders](https://github.com/thoughtbot/suspenders).
Do that first, then install buildo and run it.

If your user model won't be named `User`, these generators are going to cause you trouble.


## Generators

### App Base Generator

A collection of gems for building the core of your app.

    rails generate buildo:app_base

Installs:
* [operate](https://github.com/tomichj/operate) create service objects  
* [slim-rails](https://github.com/slim-template/slim-rails) templates similar to HAML, but better 
* [aasm](https://github.com/aasm/aasm) State machines for Ruby
* [reform](https://github.com/trailblazer/reform) form objects decoupled from models.
* [reform-rails](https://github.com/trailblazer/reform-rails) Automatically load and include all common Rails form features.
* [local_time](https://github.com/basecamp/local_time) Rails engine for cache-friendly, client-side local time


### Scaffolding Generator

Installs:
* [oath-generators](https://github.com/halogenandtoast/oath-generators) generators for the oath authentication library

Runs the oath generator scaffolding, which installs:
* a User model with email and password digest
* session and user controllers, routes, views to support sign up and sign in
* injects oath's helpers into application_controller.r
* a minimal config/oath/oath.en.yml

Buildo's scaffolding the installs over this:
* session_controller.rb that supports `remember_me` and other oath-lockdown features
* sessions/new.html.erb that supports `remember_me`
* sign_in, sign_out, sign_up routes
* a partial for a header with sign_in, sign_out, sign_up links

Run `rails db:migrate` after this. 


### Auth Generator*

Install oath and oath-lockdown. You should have a User model in place before you run this generator.
__If your user model is named something other than User__, you'll need to edit the migrations from this
generator.

    rails generate buildo:auth

* [oath](https://github.com/halogenandtoast/oath) rails authentication toolkit
* [oath-lockdown](https://github.com/tomichj/oath-lockdown) An authentication system for Rails built on Oath.


### Users Services

Installs:

* [User naming](https://github.com/tomichj/user_naming) naming methods for user models
* [User time zones](https://github.com/tomichj/user_time_zones) an easy way to work with multiple user time zones

Both gems generate migrations. Run `rails db:migrate` after this.


### All

Runs all of the above generators. Run `rails db:migrate` after this.


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
