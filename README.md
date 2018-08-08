# Buildo

Buildo is a base Rails application builder.

### Credits
Buildo is based on [Thoughtbot]'s incredible [suspenders] project. Thank you Thoughtbot! 
Buildo would not exist without [Thoughtbot]'s open source generosity.

You should give [suspenders] a look. It's professionally maintained by Thoughtbot, a 
top design and development consultancy.

[Thoughtbot]: https://thoughtbot.com
[suspenders]: https://github.com/thoughtbot/suspenders


## Installation

First install the buildo gem:

    gem install buildo

Then run:

    buildo projectname

This will create a Rails app in `projectname` using the latest version of Rails.

### Flags

Flag | Default | Description 
--- | --- | --- |
heroku | false | create staging and production Heroku apps
heroku_flags | '' | Set extra heroku flags
github | nil | Create Github repository and add remote origin pointed to repo
skip_test | true | Skip Test Unit
skip_users | true | Skip user services (authentication, user naming & time zones) and scaffolding
skip_segment | true | Skip segment analytics support
skip_turbolinks | false | Skip turbolinks Gem

### Standalone Generators

Buido can set up lots of services for you after app generation with generators


## Associated services

* Heroku for staging and production apps (utilize the `--heroku` flag described above).   
* [Heroku review applcations], which you can manually deploy with the `bin/setup_review_app` script.
You can also enable [Github integration] on heroku to automatically deploy review applications for
every pull request. 

[Heroku review applications]: https://devcenter.heroku.com/articles/github-integration-review-apps
[Github intergration]: https://devcenter.heroku.com/articles/github-integration

## What's installed?

To see the latest and greatest gems, look at Buildo's [Gemfile](templates/Gemfile.erb). It includes the bulk of
the gems installed by buildo (additional gems installed at runtime by generators). 

It includes application gems like:

* [Autoprefixer Rails](https://github.com/ai/autoprefixer-rails) for CSS vendor prefixes
* [Delayed Job](https://github.com/collectiveidea/delayed_job) for background processing
* [Flutie](https://github.com/thoughtbot/flutie) for `page_title` and `body_class` view helpers
* [High Voltage](https://github.com/thoughtbot/high_voltage) for static pages
* [jQuery Rails](https://github.com/rails/jquery-rails) for jQuery
* [Normalize](https://necolas.github.io/normalize.css/) for resetting browser styles
* [Postgres](https://github.com/ged/ruby-pg) for access to the Postgres database
* [Rack Canonical Host](https://github.com/tylerhunt/rack-canonical-host) to
  ensure all requests are served from the same domain
* [Rack Timeout](https://github.com/heroku/rack-timeout) to abort requests that are taking too long
* [Recipient Interceptor](https://github.com/croaky/recipient_interceptor) to
  avoid accidentally sending emails to real people from staging
* [Simple Form](https://github.com/plataformatec/simple_form) for form markup and style
* [Title](https://github.com/calebthompson/title) for storing titles in translations
* [Puma](https://github.com/puma/puma) to serve HTTP requests
* [Oath](https://github.com/halogenandtoast/oath) an authentication toolkit
* [Oath Lockdown](https://github.com/tomichj/oath-lockdown) an authentication system build on oath
* [User Naming](https://github.com/tomichj/user_naming) provides naming methods for user models
* [User Time Zones](https://github.com/tomichj/user_time_zones) an easy way to work with multiple user time zones
* [Operate](https://github.com/tomichj/operate) easily create service objects
* [Slim Rails](https://github.com/slim-template/slim-rails) provides 'slim' templating language, like haml-rails

And development gems like:

* [Dotenv](https://github.com/bkeepers/dotenv) for loading environment variables
* [Pry Rails](https://github.com/rweng/pry-rails) for interactively exploring objects
* [ByeBug](https://github.com/deivid-rodriguez/byebug) for interactively debugging behavior
* [Bullet](https://github.com/flyerhzm/bullet) for help to kill N+1 queries and unused eager loading
* [Spring](https://github.com/rails/spring) for fast Rails actions via pre-loading
* [Web Console](https://github.com/rails/web-console) for better debugging via in-browser IRB consoles.

And testing gems like:

* [Capybara](https://github.com/jnicklas/capybara) and [Google Chromedriver] integration testing
* [Factory Bot](https://github.com/thoughtbot/factory_bot) for test data
* [Formulaic](https://github.com/thoughtbot/formulaic) for integration testing HTML forms
* [RSpec](https://github.com/rspec/rspec) for unit testing
* [RSpec Mocks](https://github.com/rspec/rspec-mocks) for stubbing and spying
* [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) for common RSpec matchers
* [Timecop](https://github.com/travisjeffery/timecop) for testing time

## Other goodies

Buildo also comes with:

* The [`./bin/setup`][setup] convention for new developer setup
* The `./bin/deploy` convention for deploying to Heroku
* Rails' flashes set up and in application layout
* A few nice time formats set up for localization
* `Rack::Deflater` to [compress responses with Gzip][compress]
* A [low database connection pool limit][pool]
* [Safe binstubs][binstub]
* [t() and l() in specs without prefixing with I18n][i18n]
* An automatically-created `SECRET_KEY_BASE` environment variable in all environments
* The analytics adapter [Segment][segment] (and therefore config for Google 
  Analytics, Intercom, Facebook Ads, Twitter Ads, etc.)

[setup]: https://robots.thoughtbot.com/bin-setup
[compress]: https://robots.thoughtbot.com/content-compression-with-rack-deflater
[pool]: https://devcenter.heroku.com/articles/concurrency-and-database-connections
[binstub]: https://github.com/thoughtbot/suspenders/pull/282
[i18n]: https://github.com/thoughtbot/suspenders/pull/304
[segment]: https://segment.com


## Heroku

You can optionally create Heroku staging and production apps:

    buildo app --heroku true

This:

* Creates a staging and production Heroku app
* Sets them as `staging` and `production` Git remotes
* Configures staging with `HONEYBADGER_ENV` environment variable set to `staging`
* Creates a [Heroku Pipeline] for review apps
* Schedules automated backups for 10AM UTC for both `staging` and `production`

[Heroku Pipeline]: https://devcenter.heroku.com/articles/pipelines

You can optionally specify alternate Heroku flags:

    buildo app \
      --heroku true \
      --heroku-flags "--region eu --addons sendgrid,ssl"

See all possible Heroku flags:

    heroku help create

## Git

This will initialize a new git repository for your Rails app. You can
bypass this with the `--skip-git` option:

    buildo app --skip-git true

## GitHub

You can optionally create a GitHub repository for the newly generated Rails app.
    
    buildo app --github organization/project

This has the same effect as running:

    hub create organization/project

To create your erpo, buildo requires that you have [Hub](https://github.com/github/hub) on your system:

    brew install hub

## Spring

Buildo uses [spring](https://github.com/rails/spring) by default.
It makes Rails applications load faster, but it might introduce confusing issues
around stale code not being refreshed.
If you think your application is running old code, run `spring stop`.
And if you'd rather not use spring, add `DISABLE_SPRING=1` to your login file.

## Dependencies

Buildo requires the latest version of Ruby.

Some gems included in Buildo have native extensions. You should have GCC
installed on your machine before generating an app with Buildo.

Use [OS X GCC Installer](https://github.com/kennethreitz/osx-gcc-installer/) for
Snow Leopard (OS X 10.6).

Use [Command Line Tools for Xcode](https://developer.apple.com/downloads/index.action)
for Lion (OS X 10.7) or Mountain Lion (OS X 10.8).

We use [Google Chromedriver] for full-stack JavaScript integration testing. It
requires Google Chrome or Chromium.

PostgreSQL needs to be installed and running for the `db:create` rake task. 


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

[Google Chromedriver]: https://sites.google.com/a/chromium.org/chromedriver/home
