# @author: Anders Murphy

module GherkinRuby
  class Printer

    def create_feature_file(ast, path)
      File.new(path + "#{convert_to_fs_name(ast.name)}.feature", 'w')
    end

    def convert_to_fs_name(name)
      name.downcase.gsub(/\s/, '_')
    end

    #creates a new directory for each feature group and prints the groups corresponding feature files
    def print_feature_group(ast, path)

      path << convert_to_fs_name(ast.name)
      FileUtils.mkdir_p(path)
      ast.each do |feature_or_feature_group|
        if feature_or_feature_group.class.equal?(GherkinRuby::AST::FeatureGroup)
          print_feature_group(feature_or_feature_group,"#{path}/")
        else
          file = create_feature_file(ast, path)
          print_feature(feature_or_feature_group, file)
        end
      end
    end

    #creates a feature file in the supplied directory and writes the supplied AST(abstract syntax tree) object to it
    def print_feature(ast, path)
      file = create_feature_file(ast, path)
      tags = format_tags(ast.tags)
      file.puts tags unless tags.nil?
      file.puts format_feature(ast.name)
      file.puts format_steps(ast.background.steps)
      file.puts

      ast.each do |scenario|
        file.puts format_tags(scenario.tags)
        file.puts format_scenario(scenario.name)
        file.puts format_steps(scenario)
      end

      file.close
    end

    #prints feature name
    def format_feature(name)
      "Feature: #{name}\n\n  Background:"
    end

    #prints scenario name
    def format_scenario(name)
      "  Scenario: #{name}"
    end

    #prints steps
    def format_steps(scenario)
      result = ''
      if scenario != []
        scenario.each do |step|
          result << "    #{step.keyword} #{step.name}\n"
        end
      end
      result
    end

    #prints tags for scenarios
    def format_tags(tags)
      if tags != []
        result = ' '
        tags.each do |tag|
          result << " @#{tag.name}"
        end
      else
        return nil
      end

      result
    end

  end
end