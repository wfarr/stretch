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

### Cluster and Index Settings

``` ruby
$stretch.cluster.settings :persistent => {
  "cluster.routing.allocation.node_concurrent_recoveries" => 4
}

$stretch.index('foo').settings :index => { :number_of_replicas => 2 }
```

### Opening and Closing Indices

``` ruby
$stretch.index('foo').open!
$stretch.index('bar').close!
```
