require 'colorize'

module Shared
  def console_msg(level, msg)

    symbols = {
        "info" => "\u24D8",
        "success" => "\u2713",
        "warn" => "\u26A0",
        "error" => "\u2622"
    }

    puts "\n "

    case level
    when "info"
      puts "\t  #{symbols.fetch(level)} #{msg}".colorize(:light_blue).bold
    when "success"
      # puts "\t \u2713 #{msg}".colorize(:light_blue).bold
      puts "\t #{symbols.fetch(level)} #{msg}".colorize(:light_blue).bold
    when "warn"
      puts "\t  #{symbols.fetch(level)} #{msg}".colorize(:yellow).bold
    when "error"
      puts "\t #{symbols.fetch(level)} #{msg}".colorize(:light_red).bold
    else
      puts "\t Level input does not match".colorize(:green).bold
    end

    puts "\n "
  end
end