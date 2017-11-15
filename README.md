ActiveRecord Tablefree
======================

| Project                 |  ActiveRecord Tablefree |
|------------------------ | ----------------------- |
| gem name                |  activerecord-tablefree |
| license                 |  MIT                    |
| download rank           |  [![Total Downloads](https://img.shields.io/gem/rt/activerecord-tablefree.png)](https://rubygems.org/gems/activerecord-tablefree) |
| version                 |  [![Gem Version](https://badge.fury.io/rb/activerecord-tablefree.png)](http://badge.fury.io/rb/activerecord-tablefree) |
| dependencies            |  [![Dependency Status](https://gemnasium.com/badges/github.com/boltthreads/activerecord-tablefree.svg)](https://gemnasium.com/github.com/boltthreads/activerecord-tablefree) |
| code quality            |  [![Code Climate](https://codeclimate.com/github/boltthreads/activerecord-tablefree.png)](https://codeclimate.com/github/boltthreads/activerecord-tablefree) |
| continuous integration  |  [![Build Status](https://travis-ci.org/boltthreads/activerecord-tablefree.svg?branch=master)](https://travis-ci.org/boltthreads/activerecord-tablefree) |
| test coverage           |  [![Coverage Status](https://coveralls.io/repos/github/boltthreads/activerecord-tablefree/badge.png?branch=master)](https://coveralls.io/github/boltthreads/activerecord-tablefree?branch=master) |
| triage helpers          |  [![Issue Triage](https://www.codetriage.com/boltthreads/activerecord-tablefree/badges/users.png)](https://www.codetriage.com/boltthreads/activerecord-tablefree) |
| homepage                |  [https://github.com/boltthreads/activerecord-tablefree](https://github.com/boltthreads/activerecord-tablefree) |
| documentation           |  [http://rdoc.info/github/boltthreads/activerecord-tablefree/frames](http://rdoc.info/github/boltthreads/activerecord-tablefree/frames) |
| readme hit counter      |  [![ghit.me](https://ghit.me/badge.svg?repo=boltthreads/activerecord-tablefree)](https://ghit.me/repo/boltthreads/activerecord-tablefree) |

A simple implementation of the ActiveRecord Tableless pattern for any
Rails project or other Ruby project that uses ActiveRecord.

Why, why, why
-------------

Why would you ever consider this gem as opposed to ActiveModel.

ActiveModel::Model does not support relations and nested attributes.


Installation
------------

ActiveRecord Tablefree is distributed as a gem, which is how it should
be used in your app.

Include the gem in your Gemfile:

    gem "activerecord-tablefree", "~> 1.0"


Supported Versions
------------------

Supported ruby version are

  * **2.2.x** series higher than 2.2.2
  * **2.3.x** series

If you are using Ruby version < 2.2.2 you can use the gem version <
2.0 like this

    gem "activerecord-tablefree", "~> 1.0.0"

Supported ActiveRecord versions are

  * **3.0.x** series
  * **3.2.x** series
  * **4.1.x** series
  * **4.2.x** series

If you are using ActiveRecord 2.3.x series you can use the gem version <
2.0 like this

    gem "activerecord-tablefree", "~> 1.0.0"

You may be able to make it work with 3.1.x, but you should expect to
put some time in it.

TODO
----

  * Support Rails 5.x series

Usage
-----

Define a model like this:

    class ContactMessage < ActiveRecord::Base
      has_no_table
      column :name, :string
      column :email, :string
      validates_presence_of :name, :email
    end

You can now use the model in a view like this:

    <%= form_for :message, @message do |f| %>
      Your name: <%= f.text_field :name %>
      Your email: <%= f.text_field :email %>
    <% end %>

And in the controller:

    def message
      @message = ContactMessage.new
      if request.post?
        @message.attributes = params[:message]
        if @message.valid?
          # Process the message...
        end
      end
    end

If you wish (this is not recommended), you can pretend you have a succeeding database by using

    has_no_table :database => :pretend_success


Development
-----------

To start developing, please download the source code

    git clone git://github.com/boltthreads/activerecord-tablefree.git

Install development libraries

    sudo apt-get install -y libsqlite3-dev libxml2-dev libxslt-dev

When downloaded, you can start issuing the commands like

    bundle install
    bundle update
    bundle exec appraisal generate
    bundle exec appraisal install
    bundle exec appraisal rake all

Or you can see what other options are there:

    bundle exec rake -T

Publishing gem
--------------

```
gem bump -v pre
```

Verify everything is OK.

```
gem build activerecord-tablefree.gemspec
```

Verify everything is OK.

```
gem release -t
```


History
-------

Originally this code was implemented for Rails 2 by Kenneth
Kalmer. For Rails 3 the need for this functionality was reduced
dramatically due to the introduction of ActiveModel. But because the
ActiveModel does not support relations and nested attributes the
existence of this gem is still justified.

Rails 3 and 4 support is provided in the [activerecord-tableless gem](https://github.com/softace/activerecord-tableless), by [Jarl Friis](https://github.com/jarl-dk).

This gem is a Rails 5 compatible update, and renaming of that gem.

For a history of technical implementation details feel free to take a
look in the git log :-)


Copyright
---------

Copyright (c) Jarl Friis.
Copyright (c) Peter Boling, Bolt Threads.

The license is MIT.  See LICENSE.txt for further details.
