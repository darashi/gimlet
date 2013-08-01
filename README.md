# Gimlet

Document-oriented, Text-based and Read-only data storage

Gimlet is strongly inspired by [Local Data](http://middlemanapp.com/advanced/local-data/) of [Middleman](http://middlemanapp.com/). It is so handy, but it is built in middleman.

Gimlet let us to use this feature for general purposes that do not fit middleman with.

## Installation

Add this line to your application's Gemfile:

    gem 'gimlet'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gimlet

## Usage

Put `data/people/homuhomu.yaml`,

    ---
    first_name: Akemi
    last_name: Homura

Then you can access the data:

    require 'gimlet'

    DB = Gimlet::DataStore.new('data')

    p data.to_h                 #=> {"homuhomu"=>{"first_name"=>"Akemi", "last_name"=>"Homura"}}
    p data.homuhomu             #=> {"first_name"=>"Akemi", "last_name"=>"Homura"}
    p data[:homuhomu].last_name #=> "Homura"


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
