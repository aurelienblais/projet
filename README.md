# Projet LP71 - UTBM

Auteur : Aurélien Blais

[![Maintainability](https://api.codeclimate.com/v1/badges/42b6b542ffa5e9c03df9/maintainability)](https://codeclimate.com/github/aurelienblais/projet/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/42b6b542ffa5e9c03df9/test_coverage)](https://codeclimate.com/github/aurelienblais/projet/test_coverage)
[![Build Status](https://travis-ci.org/aurelienblais/projet.svg?branch=master)](https://travis-ci.org/aurelienblais/projet)
## Dependencies

* Ruby 2.2.2
* Postgres 9.6.3

## Setup

* Clone repo
* Copy `config/database_sample.yml` to `config/database.yml`
* `bundle`
* `rails s`

## Docker

Make sure the mount point is set in the `docker-compose.yml` file (and added as data folder *[For Docker OSX]*)
_Warning:_ Port is forwarded to 5433 in order to avoid conflict with running Postgres

To use it, run `docker-compose up -d` or `docker-compose up`
