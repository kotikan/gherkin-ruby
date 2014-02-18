require 'tmpdir'
require_relative '../test_helper'
include Helpers

module GherkinRuby
  describe PrintingVisitor do
    it 'should print a feature file' do
      Dir.mktmpdir { |dir|
        feature = create_feature
        parser = GherkinRuby::Parser.new
        printer = GherkinRuby::PrintingVisitor.new dir
        ast = parser.parse(feature)

        printer.visit(ast)

        file = "#{dir}/serve_coffee.feature"
        File.exists?(file).must_equal true
        file_contents = File.read file
        file_contents.must_equal feature
      }
    end

    it 'should print a group of feature files' do
      Dir.mktmpdir { |dir|
        parser = GherkinRuby::Parser.new
        printer = GherkinRuby::PrintingVisitor.new dir
        features = [
            create_feature,
            create_feature_with_scenario_outline
        ]
        ast = GherkinRuby::AST::FeatureGroup.new('group_name', [
            parser.parse(features[0]),
            parser.parse(features[1])
        ])

        printer.visit(ast)

        files = [
            "#{dir}/group_name/serve_coffee.feature",
            "#{dir}/group_name/serve_many_coffees.feature"
        ]

        files.each_with_index do |file, i|
          File.exists?(file).must_equal true
          file_contents = File.read file
          file_contents.must_equal features[i]
        end
      }
    end

    it 'should print a nested group of feature files' do
      Dir.mktmpdir { |dir|
        parser = GherkinRuby::Parser.new
        printer = GherkinRuby::PrintingVisitor.new dir
        features = [
            create_feature,
            create_feature_with_scenario_outline
        ]
        ast = GherkinRuby::AST::FeatureGroup.new('first_group', [
            GherkinRuby::AST::FeatureGroup.new('first_inner', [
                parser.parse(features[0])
            ]), GherkinRuby::AST::FeatureGroup.new('second_inner', [
                parser.parse(features[1])
            ])
        ])

        printer.visit(ast)


        files = [
            "#{dir}/first_group/first_inner/serve_coffee.feature",
            "#{dir}/first_group/second_inner/serve_many_coffees.feature"
        ]

        files.each_with_index do |file, i|
          File.exists?(file).must_equal true
          file_contents = File.read file
          file_contents.must_equal features[i]
        end
      }
    end

    it 'should not print groups that contain no feature files' do
      Dir.mktmpdir { |dir|
        parser = GherkinRuby::Parser.new
        printer = GherkinRuby::PrintingVisitor.new dir
        features = [
            create_feature,
            create_feature_with_scenario_outline
        ]
        ast = GherkinRuby::AST::FeatureGroup.new('first_group', [
            GherkinRuby::AST::FeatureGroup.new('not_empty', [
                parser.parse(features[0])
            ]), GherkinRuby::AST::FeatureGroup.new('empty')
        ])

        printer.visit(ast)

        file = "#{dir}/first_group/not_empty/serve_coffee.feature"
        dir = "#{dir}/first_group/empty"

        File.exists?(file).must_equal true
        Dir.exist?(dir).must_equal false
      }
    end
  end
end