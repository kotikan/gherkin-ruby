# @author: Anders Murphy

module GherkinRuby
  class Printer

    #creates a feature file in the supplied directory and writes the supplied AST(abstract syntax tree) object to it
    def print(ast, path)
      result = feature(ast.instance_variable_get('@name'))
      #prints background steps
      ast.background.instance_variable_get('@steps').each do |step|
        result << step(step.instance_variable_get('@keyword'), step.instance_variable_get('@name'))
      end
      #prints scenarios
      ast.instance_variable_get('@scenarios').each do |scenario|
        result << scenario(scenario.instance_variable_get('@name'))
        #prints scenario steps
        scenario.instance_variable_get('@steps').each do |step|
          result << step(step.instance_variable_get('@keyword'), step.instance_variable_get('@name'))
        end
      end
      #creates a feature file named after the feature and writes result to the file (path is relative to home directory)
      out_file = File.new(ENV['HOME'] + "/#{path}#{ast.instance_variable_get('@name')}.feature", 'w')
      out_file.puts(result)
      out_file.close
    end

    def feature(name)
      "Feature: #{name}\n\n  Background:\n"
    end

    def scenario(name)
      "\n  Scenario: #{name}\n"
    end

    def step(keyword, name)
      "    #{keyword} #{name}\n"
    end
  end
end