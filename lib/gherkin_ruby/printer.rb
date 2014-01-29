# @author: Anders Murphy

module GherkinRuby
  class Printer

    #creates a feature file in the supplied directory and writes the supplied AST(abstract syntax tree) object to it
    def print(ast, path)
      result = format_tags(ast.tags)
      result << format_feature(ast.name)
      result << format_steps(ast.background.steps)
      #prints scenarios
      ast.scenarios.each do |scenario|
        result << format_tags(scenario.tags)
        result << format_scenario(scenario.name)
        result << format_steps(scenario.steps)
      end
      #creates a feature file named after the feature and writes result to the file (path is relative to home directory)
      result.strip!
      out_file = File.new(ENV['HOME'] + "/#{path}#{ast.name}.feature", 'w')
      out_file.puts(result)
      out_file.close
    end

    #prints feature name
    def format_feature(name)
      "Feature: #{name}\n\n  Background:\n"
    end

    #prints scenario name
    def format_scenario(name)
      "  Scenario: #{name}\n"
    end

    #prints steps
    def format_steps(steps)
      result = ''
      if steps != []
        steps.each do |step|
          result << "    #{step.keyword} #{step.name}\n"
        end
        result << "\n"
      end
      result
    end

    #prints tags for scenarios
    def format_tags(tags)
      result = ''
      if tags != []
        result = ' '
        tags.each do |tag|
          result << " @#{tag.name}"
        end
        result << "\n"
      end
      result
    end

  end
end