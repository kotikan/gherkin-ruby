require_relative 'gherkin_ruby/version'
require_relative 'gherkin_ruby/ast'
require_relative 'gherkin_ruby/parser'
require_relative 'gherkin_ruby/printing_visitor'
require_relative 'gherkin_ruby/folder_parser'

module GherkinRuby
  def self.parse(input)
    parser = Parser.new
    parser.parse(input)
  end

  def self.print(ast, path)
    printer = PrintingVisitor.new(path)
    printer.visit(ast)
  end

  def self.parse_folder(path,feature_group_name)
    folder_parser = FolderParser.new
    folder_parser.parse_folder(path,feature_group_name)
  end

end
