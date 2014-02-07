require "irc-log-parser/version"

module IrcLogParser
  autoload :Log,              'irc-log-parser/log'
  autoload :Logs,             'irc-log-parser/logs'
  autoload :Tiarra,           'irc-log-parser/tiarra'
  autoload :Znc,              'irc-log-parser/znc'
  autoload :UnknownTypeError, 'irc-log-parser/unknown_type_error'
end

