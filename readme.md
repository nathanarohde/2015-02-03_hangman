Hangman
Play the game hangman.  Features delightfully morbid text messages that inform you how close you are to death.

by Monty Rohde Ruby version 2.20

Copyright 2015 Nathan Rohde

License: GPL v2 Created by Nathan Rohde

Program is created using Activerecord and Sinatra.

Install Hangman by first cloning the repository:
git clone https://github.com/nathanarohde/2015-02-03_hangman

Gems included: gem('sinatra') gem('sinatra-contrib', :require => 'sinatra/reloader') gem('sinatra-activerecord') gem('rake') gem('pg')

For test database. gem('rspec') gem('shoulda-matchers')

Install all of the required gems in irb: $ bundle install $ bundle

Accepts only strings of letters and spaces under 40 characters long.
Has full CRUD functionality.
