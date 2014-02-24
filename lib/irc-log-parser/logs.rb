require 'date'
require 'json'

module IrcLogParser
  class Logs < Array
    def initialize(type, path)
      @type = type
      @path = File.expand_path path
      load_file
      parse_path
      parse_logs
    end

    def network
      @network
    end

    def date
      @date
    end

    def channel
      @channel
    end

    private
    def parse_logs
      @logs.each do |log|
        begin
          self << parse(log)
        rescue UnknownTypeError => e
        end
      end
    end

    def load_file
      file = open(@path).read
      file.force_encoding('UTF-8')
      file = file.encode("UTF-16BE", "UTF-8", :invalid => :replace, :undef => :replace, :replace => '?').encode("UTF-8")
      @logs = file.split(/(\n|\r|\r\n)/)
    end

    def parse_path
      filename = File.basename(@path).gsub(/\.\w+$/, '')
      dirname  = File.dirname(@path).split('/').last
      case @type
      when :tiarra
        @channel, @network = dirname.split('@')
        @date = Date.parse filename
      when :znc
        if /^(\w+_)?(\w+)_(#?.+)_(\d+)$/ =~ filename
          @network = $2
          @channel = $3
          @date = Date.parse $4
        end
      end
    end

    def parse(line)
      case @type
      when :tiarra
        if @network and @date
          Tiarra.parse @network, @date, line
        end
      when :znc
        if @network and @channel and @date
          Znc.parse @network, @channel, @date, line
        end
      end
    end
  end
end
