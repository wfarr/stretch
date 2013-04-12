# Stretch

Elasticsearch client library written for people who like understandable
documentation and understandable code.

## Installation

Add this line to your application's Gemfile:

    gem 'stretch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stretch

## Usage

### Cluster Health

``` ruby
Stretch.cluster.health
```

### Index Health

``` ruby
Stretch.index('tweets').health
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
