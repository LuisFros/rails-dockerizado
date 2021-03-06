# Rails Dockerizado [![Circle CI](https://circleci.com/gh/platanus/rails-dockerizado.svg?style=svg)](https://circleci.com/gh/platanus/rails-dockerizado)
This is a Rails application, initially generated using [Potassium](https://github.com/platanus/potassium) by Platanus.

## Local installation
First, make sure you have [docker](https://docs.docker.com/install/) and [docker-compose](https://docs.docker.com/compose/install/) installed

Assuming you've just cloned the repo, run the following commands:

1. Build the images

```
docker-compose build
```

2. Run the setup binstub

```
docker-compose run runner ./bin/setup
```
It assumes you have a machine equipped Docker

The script will do the following among other things:

- Install the dependecies
- Prepare your database
- Adds heroku remotes

3. After the app setup is done you can run it with 

```
docker-compose up <service_name1> <service_name2> ...
```
For example to run with only Rails and Webpacker:
```
docker-compose up rails webpacker
```
Run with Rails, Webpacker and Sidekiq:
```
docker-compose up rails webpacker sidekiq
```

- To run any commands for the rails app, use the `runner` service.
```
docker-compose run runner <command_name>
```

## Deployment

This project is pre-configured to be (easily) deployed to Heroku servers, but needs you to have the Potassium binary installed. If you don't, then run:

    $ gem install potassium

Then, make sure you are logged in to the Heroku account where you want to create the app and run

    $ potassium install heroku --force

this will create the app on heroku, create a pipeline and link the app to the pipeline.

You'll still have to manually log in to the heroku dahsboard, go to the new pipeline and 'configure automatic deploys' using Github
You can run the following command to open the dashboard in the pipeline page

    $ heroku pipelines:open

![Hint](https://cloud.githubusercontent.com/assets/313750/13019759/fa86c8ca-d1af-11e5-8869-cd2efb5513fa.png)

Remember to connect each stage to the corresponding branch:

1. Staging -> Master
2. Production -> Production

That's it. You should already have a running app and each time you push to the corresponding branch, the system will (hopefully) update accordingly.


## Continuous Integrations

The project is setup to run tests
in [CircleCI](https://circleci.com/gh/platanus/rails-dockerizado/tree/master)

You can also run the test locally simulating the production environment using docker.
Just make sure you have docker installed and run:

    bin/cibuild


## Style Guides

The style guides are enforced through a self hosted version of [Hound CI](http://monkeyci.platan.us). The style configuration can also be used locally
in development runing `rubocop` or just using the rubocop integration for your text editor of choice.

You can add custom rules to this project just adding them to the `.ruby-style.yml` file.


## Sending Emails

The emails can be send through the gem `send_grid_mailer` using the `sendgrid` delivery method.
All the `action_mailer` configuration can be found at `config/mailer.rb`, which is loaded only on production environments.

All emails should be sent using background jobs, by default we install `sidekiq` for that purpuse.

#### Testing in staging

If you add the `EMAIL_RECIPIENTS=` environmental variable, the emails will be intercepted and redirected to the email in the variable.


## Internal dependencies

### Authorization

For defining which parts of the system each user has access to, we have chosen to include the [Pundit](https://github.com/elabs/pundit) gem, by [Elabs](http://elabs.se/).

### Authentication

We are using the great [Devise](https://github.com/plataformatec/devise) library by [PlataformaTec](http://plataformatec.com.br/)

### Active Storage

For managing uploads, this project uses [Active Storage](https://github.com/rails/rails/tree/master/activestorage).

### Rails pattern enforcing types

This projects uses [Power-Types](https://github.com/platanus/power-types) to generate Services, Commands, Utils and Values.

### Presentation Layer

This project uses [Draper](https://github.com/drapergem/draper) to add an object-oriented layer of presentation logic

### Error Reporting

To report our errors we use [Sentry](https://github.com/getsentry/raven-ruby)

### Scheduled Tasks

To schedule recurring work at particular times or dates, this project uses [Sidekiq Scheduler](https://github.com/moove-it/sidekiq-scheduler)

### Queue System

For managing tasks in the background, this project uses [Sidekiq](https://github.com/mperham/sidekiq)

## Seeds

To populate your database with initial data you can add, inside the `/db/seeds.rb` file, the code to generate **only the necessary data** to run the application.
If you need to generate data with **development purposes**, you can customize the `lib/fake_data_loader.rb` module and then to run the `rake load_fake_data` task from your terminal.

