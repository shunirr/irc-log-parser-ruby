# IrcLogParser

IrcLogParser is parsing tiarra and znc log.

## Installation

Add this line to your application's Gemfile:

    gem 'irc-log-parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install irc-log-parser

## Usage

```ruby
require 'irc-log-parser'
```

Load irc logs.

```ruby
# tiarra
logs = IrcLogParser::Logs.new(:tiarra, '~/tiarra/logs/#channel@network/2014.01.01.txt')

# znc
logs = IrcLogParser::Logs.new(:znc, "~/.znc/moddata/log/shunirr_network_\#channel_20140101.log")
```

```ruby
logs[0].to_json
# => "{\"network\":\"network\",\"channel\":\"#channel\",\"time\":\"2014-01-01 00:00:00 +0900\",\"nick\":\"shunirr\",\"text\":\"Hello world\",\"is_notice\":false}"

logs[0].to_ltsv
# => "network:network\tchannel:#channel\ttime:2014-01-01 00:00:00 +0900\tnick:shunirr\ttext:Hello world\tis_notice:false\t"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
