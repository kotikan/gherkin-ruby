# @author: Anders Murphy

require_relative '../test_helper'

module GherkinRuby
  describe 'parses a directory of feature files' do
    before do
      @scenario = """"""
      path ='fixtures/'
      folder_parser  = GherkinRuby::FolderParser.new
      @result = folder_parser.parse_folder(path, 'fixtures')
    end

    it 'generates a nice tree' do
      @result.must_be_kind_of AST::FeatureGroup
      @result.name.must_equal('fixtures')

      first_feature = @result.features_and_feature_groups.first
      first_feature.must_be_kind_of AST::Feature
      first_feature.name.must_equal('Serve coffee')
      first_feature.background.must_be_kind_of AST::Background

      last_feature = @result.features_and_feature_groups.last
      last_feature.must_be_kind_of AST::Feature
      last_feature.name.must_equal('Serve super coffee')
      last_feature.background.must_be_kind_of AST::Background

      first_feature_first_scenario = @result.features_and_feature_groups.first.scenarios.first
      first_feature_first_scenario.must_be_kind_of AST::Scenario
      first_feature_first_scenario.name.must_equal('Buy last coffee')

      first_feature_last_scenario = @result.features_and_feature_groups.first.scenarios.last
      first_feature_last_scenario.must_be_kind_of AST::Scenario
      first_feature_last_scenario.name.must_equal('No coffee')

      last_feature_first_scenario = @result.features_and_feature_groups.last.scenarios.first
      last_feature_first_scenario.must_be_kind_of AST::Scenario
      last_feature_first_scenario.name.must_equal('Buy last super coffee')

      last_feature_last_scenario = @result.features_and_feature_groups.last.scenarios.last
      last_feature_last_scenario.must_be_kind_of AST::Scenario
      last_feature_last_scenario.name.must_equal('No super coffee')

      first_feature_first_scenario_first_step = @result.features_and_feature_groups.first.scenarios.first.steps.first
      first_feature_first_scenario_first_step.must_be_kind_of AST::Step

      first_feature_first_scenario_last_step = @result.features_and_feature_groups.first.scenarios.first.steps.last
      first_feature_first_scenario_last_step.must_be_kind_of AST::Step

      first_feature_last_scenario_first_step = @result.features_and_feature_groups.first.scenarios.last.steps.first
      first_feature_last_scenario_first_step.must_be_kind_of AST::Step

      first_feature_last_scenario_last_step = @result.features_and_feature_groups.first.scenarios.last.steps.last
      first_feature_last_scenario_last_step.must_be_kind_of AST::Step

      last_feature_first_scenario_first_step = @result.features_and_feature_groups.last.scenarios.first.steps.first
      last_feature_first_scenario_first_step.must_be_kind_of AST::Step

      last_feature_first_scenario_last_step = @result.features_and_feature_groups.last.scenarios.first.steps.last
      last_feature_first_scenario_last_step.must_be_kind_of AST::Step

      last_feature_last_scenario_first_step = @result.features_and_feature_groups.last.scenarios.last.steps.last
      last_feature_last_scenario_first_step.must_be_kind_of AST::Step

      last_feature_last_scenario_last_step = @result.features_and_feature_groups.last.scenarios.last.steps.last
      last_feature_last_scenario_last_step.must_be_kind_of AST::Step
    end
  end
end