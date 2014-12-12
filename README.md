# Tally.us Documentation
Tally.us is a website and, eventually, a mobile application that makes it easier to make donations to political candidates and incumbants while at the same time making politicians more accountable for their actions. 

Tally updates around the clock with news about candidates and politicians. For each action that politicians take, users can send $5 to the politicians for actions they approve, or $5 to an opponent for actions they oppose. Tally keeps, well, a tally of the donations for every action, bringing transparency and accountability to political donations.

##Tech stack:
* Ruby on Rails for administration of politician data, news content management system and payments
* Javascript with Backbone.js for front-end interface
* Postgres for database
* Heroku for hosting environment

Tally uses these gems in Rails:
* Devise: handles user authentication
* Figaro: keeps API information secure for pushing code to Github
* Pry: for easing testing and development
* Braintree: handles payment processing

If you would like to create a local version of Tally.us:
~~~
git clone https://github.com/kourosh/tally.git
~~~
Since we use API keys, you will need to use your own. One option is to use Figaro to manage your own API key:

~~~
gem 'figaro'
~~~

Don't forget to run bundle install.
