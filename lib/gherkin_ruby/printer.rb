# @author: Anders Murphy

module GherkinRuby
  class Printer

    #
    def print_feature_group(ast, path)
      path << ast.name
      FileUtils.mkdir_p(ENV['HOME'] + "/#{path}")
      ast.each do |feature_or_feature_group|
        if feature_or_feature_group.class.equal?(GherkinRuby::AST::FeatureGroup)
          print_feature_group(feature_or_feature_group,"#{path}/")
        else
          print_feature(feature_or_feature_group,"#{path}/")
        end
      end
    end

    #creates a feature file in the supplied directory and writes the supplied AST(abstract syntax tree) object to it
    def print_feature(ast, path)
      result = format_tags(ast.tags)
      result << format_feature(ast.name)
      result << format_steps(ast.background.steps)
      #prints scenarios
      ast.each do |scenario|
        result << format_tags(scenario.tags)
        result << format_scenario(scenario.name)
        result << format_steps(scenario)
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
    def format_steps(scenario)
      result = ''
      if scenario != []
        scenario.each do |step|
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