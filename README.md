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

### Establishing a connection:

``` ruby
$stretch = Stretch::Client.new :url => "http://127.0.0.1:9200/"
```

### Cluster and Index Health

``` ruby
$stretch.cluster.health :timeout => '10s'
$stretch.index('tweets').health :wait_for_status => 'green'
```

### Cluster State

``` ruby
$stretch.cluster.state
$stretch.cluster.state :filter_nodes => true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
