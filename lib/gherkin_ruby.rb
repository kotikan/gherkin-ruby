require_relative 'gherkin_ruby/version'
require_relative 'gherkin_ruby/ast'
require_relative 'gherkin_ruby/parser'
require_relative 'gherkin_ruby/printer'

module GherkinRuby
  def self.parse(input)
    parser = Parser.new
    parser.parse(input)
  end

  def self.print(input)
    printer = Printer.new
    printer.print(input)
  end

end
