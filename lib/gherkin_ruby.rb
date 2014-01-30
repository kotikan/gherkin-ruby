require_relative 'gherkin_ruby/version'
require_relative 'gherkin_ruby/ast'
require_relative 'gherkin_ruby/parser'
require_relative 'gherkin_ruby/printer'
require_relative 'gherkin_ruby/folder_parser'

module GherkinRuby
  def self.parse(input)
    parser = Parser.new
    parser.parse(input)
  end

  def self.print(ast,path)
    printer = Printer.new
    printer.print_feature(ast,path)
  end

  def self.parse_folder(path,feature_group_name)
    folder_parser = FolderParser.new
    folder_parser.parse_folder(path,feature_group_name)
  end

end
