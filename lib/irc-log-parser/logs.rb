require 'date'

module IrcLogParser
  class Logs < Array
    def initialize(type, path)
      @type = type
      @path = File.expand_path path
      load_file
      parse_path
      parse_logs
    end

    private
    def parse_logs
      @logs.each do |log|
        begin
          self << parse(log)
        rescue ParseException => e
        end
      end
    end

    def load_file
      file = open(@path).read
      file.encode "UTF-16BE", "UTF-8", invalid: :replace, undef: :replace, replace: '.'
      file.encode "UTF-8"
      @logs = file.split /(\n|\r|\r\n)/
    end

    def parse_path
      filename = File.basename(@path).gsub(/\.\w+$/, '')
      dirname  = File.dirname(@path).split('/').last
      case @type
      when :tiarra
        @network = dirname.split('@').last
        @date = Date.parse filename
      when :znc
        if /^\w+_(\w+)_(#?\w+)_(\d+)$/ =~ filename
          @network = $1
          @channel = $2
          @date = Date.parse $3
        end
      end
    end

    def parse(line)
      case @type
      when :tiarra
        Tiarra.parse @network, @date, line
      when :znc
        Znc.parse @network, @channel, @date, line
      end
    end
  end
end
