# Compile with: racc gherkin.y -o parser.rb

class GherkinRuby::Parser

# Declare tokens produced by the lexer
token NEWLINE
token FEATURE BACKGROUND SCENARIO OUTLINE EXAMPLES
token TAG
token GIVEN WHEN THEN AND BUT
token DOC_STRING_START DOC_STRING_LINE DOC_STRING_END
token TABLE_ROW_START TABLE_CELL
token TEXT

rule

  Root:
    Feature     { result = val[0]; }
  |
    Feature
      Scenarios { result = val[0]; result.scenarios = val[1] }
  | FeatureTags Feature { result = val[1]; result.tags = val[0] }
  | FeatureTags Feature 
      Scenarios { result = val[1]; result.scenarios = val[2]; result.tags = val[0] }
  ;

  Newline:
    NEWLINE
  | Newline NEWLINE
  ;

  FeatureTags:
    Tags { result = val[0] }
  | Newline Tags { result = val[1] }

  Feature:
    FeatureHeader { result = val[0] }
  | FeatureHeader
      Background  { result = val[0]; result.background = val[1] }
  ;

  FeatureHeader:
    FeatureName           { result = val[0] }
  | FeatureName Newline   { result = val[0] }
  | FeatureName Newline
      Description         { result = val[0]; result.description = val[2] }
  ;

  FeatureName:
    FEATURE TEXT          { result = AST::Feature.new(val[1]); result.pos(filename, lineno) }
  | Newline FEATURE TEXT  { result = AST::Feature.new(val[2]); result.pos(filename, lineno) }
  ;

  Description:
    TEXT Newline             { result = [val[0]] }
  | Description TEXT Newline { result = val[0] << val[1] }
  ;

  Background:
    BackgroundHeader
      Steps               { result = val[0]; result.steps = val[1] }
  ;

  BackgroundHeader:
    BACKGROUND Newline    { result = AST::Background.new; result.pos(filename, lineno) }
  ;

  Steps:
    Step                            { result = [val[0]] }
  | Step Newline                    { result = [val[0]] }
  | Step Newline DocString          { val[0].doc_string = val[2]; result = [val[0]] }
  | Step Newline DocString Newline  { val[0].doc_string = val[2]; result = [val[0]] }
  | Step Newline Table              { val[0].table = val[2]; result = [val[0]] }
  | Step Newline Table Newline      { val[0].table = val[2]; result = [val[0]] }
  | Step Newline Steps              { val[2].unshift(val[0]); result = val[2] }
  ;

  Step:
    Keyword TEXT            { result = AST::Step.new(val[1], val[0]); result.pos(filename, lineno) }
  ;

  Keyword:
    GIVEN | WHEN | THEN | AND | BUT
  ;

  DocString:
    DOC_STRING_START Newline DocStringLines Newline DOC_STRING_END { result = val[2] }
  ;

  DocStringLines:
    DOC_STRING_LINE                         { result = [val[0]] }
  | DocStringLines Newline DOC_STRING_LINE  { result = val[0] << val[2] }
  ;

  Table:
    TableRow { result = [AST::TableRow.new(val[0])] }
  | Table Newline TableRow { val[0] << AST::TableRow.new(val[2]); result = val[0] }
  ;

  TableRow:
    TABLE_ROW_START TableCells { result = val[1] }
  ;

  TableCells:
    TABLE_CELL              { result = [val[0]] }
  | TableCells TABLE_CELL   { result = val[0] << val[1] }
  ;

  Scenarios:
    Scenario              { result = [val[0]] }
  | Scenarios Scenario    { result = val[0] << val[1] }
  ;

  Scenario:
    SimpleScenario
  | ScenarioOutline
  ;

  SimpleScenario:
    SCENARIO TEXT Newline
      Steps { result = AST::Scenario.new(val[1], val[3]); result.pos(filename, lineno - 1) }
  | Tags Newline
    SCENARIO TEXT Newline
      Steps { result = AST::Scenario.new(val[3], val[5], val[0]); result.pos(filename, lineno - 2) }
  ;

  ScenarioOutline:
    OUTLINE TEXT Newline
      Steps Examples { result = AST::ScenarioOutline.new(val[1], val[3], val[4]); result.pos(filename, lineno - 1) }
  | Tags Newline
      OUTLINE TEXT Newline
      Steps Examples { result = AST::ScenarioOutline.new(val[3], val[5], val[6], val[0]); result.pos(filename, lineno - 2) }
  ;

  Examples:
    EXAMPLES Newline
        Table { result = AST::ExamplesTable.new(val[2]) }
  | EXAMPLES Newline
      Table Newline { result = AST::ExamplesTable.new(val[2]) }
  ;

  Tags:
    TAG         { result = [AST::Tag.new(val[0])] }
  | Tags TAG    { result = val[0] << AST::Tag.new(val[1]) }
  ;

end

---- header
  require_relative "lexer"
  require_relative "../ast"

---- inner

  def parse(input)
    @yydebug = true if ENV['DEBUG_RACC']
    scan_str(input)
  end
