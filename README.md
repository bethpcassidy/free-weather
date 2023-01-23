# EZWeather (Backened)

EZWeather is a website that gathers and displays weather information for registered users.

It uses geocoded api data to determine the weather forecast at the center of a given zipcode, by processing information for the next 24 hour period based on when the last ping was made.
Generated forecasts are saved to users so that they can be easily accessed on login.

# Requirements

Ruby 3.1.2
Rails 7.0.4

# Install

`bundle install`

`rails db:create db:migrate db:seed`

and

`rails s`

to startup the server.

To view the designed frontend, check it out here and follow the instructions: https://github.com/bethpcassidy/weather-frontend
