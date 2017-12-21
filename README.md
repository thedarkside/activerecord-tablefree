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

    gem "activerecord-tablefree", "~> 3.0"


Supported Versions
------------------

Supported ruby version are

  * **2.2.x** series higher than 2.2.2 (a Rails 5 requirement)
  * **2.3.x** series
  * **2.4.x** series

Supported ActiveRecord versions are

  * **5.0.x** series
  * **5.1.x** series

If you are using an older ActiveRecord version you can use the gem [`activerecord-tableless`](https://github.com/softace/activerecord-tableless)

This gem tries to maintain the same API as the older `activerecord-tableless` gem.

Usage
-----

Define a model like this:

    class ContactMessage < ActiveRecord::Base
      has_no_table
      column :name, :string
      column :email, :string
      column :message, :string
      validates_presence_of :name, :email, :message
    end

You can now use the model in a view like this:

    <%= form_for :contact_message, @contact_message do |f| %>
      Your name: <%= f.text_field :name %>
      Your email: <%= f.text_field :email %>
      Your message: <%= f.text_field :message %>
    <% end %>

And in the controller:

    def contact_message
      @contact_message = ContactMessage.new
      if request.post?
        @contact_message.attributes = params[:contact_message]
        if @contact_message.valid?
          # Process the message...
        end
      end
    end

If you wish (this is not recommended), you can pretend you have a succeeding database by using

    has_no_table :database => :pretend_success

Associations
------------

Some model as before, but with an association to a real DB-backed model.

```
    class ContactMessage < ActiveRecord::Base
      has_no_table
      column :message, :string
      column :email, :string
      validates_presence_of :name, :email
      belongs_to :contact, foreign_key: :email, primary_key: :email
    end

    class Contact < ActiveRecord::Base
      validates_presence_of :name, :email
      has_one :contact_message, foreign_key: :email, primary_key: :email, dependent: nil
    end
```

Obviously the association is not full-fledged, as some traversals just won't make sense with one side not being loadable from the database.  From the `ContactMessage` you can get to the `Contact`, but not vice versa.

```
>> contact = Contact.new(name: 'Boo', email: 'boo@example.com')
>> contact_message = ContactMessage.new(contact: contact)
>> contact_message.email
=> 'boo@example.com'
```

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
