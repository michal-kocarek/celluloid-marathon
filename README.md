# Celluloid::Marathon

Package extends Celluloid with actors suitable for running neverending tasks and enables their graceful termination.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'celluloid-marathon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install celluloid-marathon

## Usage

Package provides two classes, `Celluloid::Marathon::Actor` and `Celluloid::Marathon::SupervisionGroup`. Actor contains method `finish` that can be called from
outside world to let actor notify about that it should finish the neverending action it is performing right now.

From the actor itself, it can cal `finishing?` to see if it can continue or work or finish as soon as possible.

This functionality has been created because currently it is not possible to terminate an actor without killing currently running function perfectly.

## Contributing

1. Fork it (https://github.com/michal-kocarek/celluloid-marathon/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
