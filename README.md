# Bookmark Manager

## Brief

The purpose of the project was to build a bookmark manager - a website to maintain a collection of bookmarks (URLs), allowing for users to add tags and comments to bookmarks which have been added.

## User stories
```
  1.  As a user
      So that I know which are the websites most regularly visited
      I would like to see a list of bookmarks

  2.  As a user
      In order that I can easily find a website again
      I would like to be able to add new bookmarks

  3.  As a user
      In case I no longer regularly visit a particular website
      I would like to be able to delete a bookmark

  4.  As a user
      In case the reference for a particular website changes
      I would like to be able to update any one of my existing bookmarks

  5.  As a user
      So that I can share my thoughts on certain bookmarks with other users
      I would like to be able to comment on bookmarks

  6.  As a user
      So that I can quickly understand what type of bookmark I'm looking at
      I would like to be able to tag a bookmark by category

  7.  As a user
      So that I can manage my own bookmarks
      I would like to be able to log in/out of my own account
```
## Technologies used

Ruby, RSpec, Sinatra, Capybara, PostgreSQL

## Getting Started

Clone the repository from GitHub:
```
$ git clone https://github.com/PiperS52/bookmark-manager.git
$ cd bookmark-manager
```
Load the dependencies:
```
$ bundle install
```
Create a new database with tables in psql:
```
$ psql postgres;

CREATE DATABASE bookmark_manager;
CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60));
CREATE TABLE comments(id SERIAL PRIMARY KEY, text VARCHAR(240), bookmark_id INTEGER REFERENCES bookmarks (id));
CREATE TABLE tags(id SERIAL PRIMARY KEY, content VARCHAR(60));
CREATE TABLE bookmarks_tags(tag_id INTEGER REFERENCES tags (id), bookmark_id INTEGER REFERENCES bookmarks (id));
CREATE TABLE users (id SERIAL PRIMARY KEY, email VARCHAR(60), password VARCHAR(140));
```

Run the server:
```
$ rackup
```
visit http://localhost:9292/bookmarks
