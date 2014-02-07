module IrcLogParser
  class Tiarra < Log
    def self.parse(network, date, line)
      is_notice = false
      if line =~ /^(\d\d):(\d\d):(\d\d) <(#[^:]+?):([^>]+)> (.*)$/
        is_notice = false
      elsif line =~ /^(\d\d):(\d\d):(\d\d) \((#[^:]+?):([^)]+)\) (.*)$/
        is_notice = true
      end
      time = Time.local date.year, date.mon, date.mday, $1.to_i, $2.to_i, $3.to_i
      channel = $4
      nick    = $5
      text    = $6
      if network and channel and text and time and nick
        new(network:network, channel:channel, text:text, time:time, nick:nick, is_notice:is_notice)
      else
        raise UnknownTypeError.new
      end
    end
  end
end
