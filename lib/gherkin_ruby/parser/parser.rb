#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.11
# from Racc grammer file "".
#

require 'racc/parser.rb'

  require_relative "lexer"
  require_relative "../ast"

module GherkinRuby
  class Parser < Racc::Parser

module_eval(<<'...end gherkin.y/module_eval...', 'gherkin.y', 157)

  def parse(input)
    @yydebug = true if ENV['DEBUG_RACC']
    scan_str(input)
  end
...end gherkin.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
    21,    21,    21,    21,    21,     4,     9,    21,    40,    41,
    42,    43,    44,    63,    21,    83,    65,    47,    65,    65,
    21,    40,    41,    42,    43,    44,     4,    21,    21,    65,
    49,    50,    24,    90,    89,    40,    41,    42,    43,    44,
    21,    16,    18,     4,    10,    21,     4,    40,    41,    42,
    43,    44,    40,    41,    42,    43,    44,    21,    16,    18,
    53,    10,    21,    21,    40,    41,    42,    43,    44,    40,
    41,    42,    43,    44,    21,    23,     4,     9,    16,    18,
    10,    10,    10,    40,    41,    42,    43,    44,    16,    18,
    54,    10,    21,    23,    34,    32,    57,    58,     4,    30,
     4,     4,     4,     4,    70,     4,     4,     4,    75,    21,
    29,     4,     4,    27,    24,    36,    84,    70,    24,     4,
     4,    11,     4 ]

racc_action_check = [
    28,    52,    73,    78,    88,     3,     3,    55,    52,    52,
    52,    52,    52,    52,    72,    73,    52,    28,    78,    88,
    87,    72,    72,    72,    72,    72,    17,    33,    67,    72,
    33,    33,    17,    87,    87,    67,    67,    67,    67,    67,
    71,    35,    35,    32,    35,    48,    38,    71,    71,    71,
    71,    71,    48,    48,    48,    48,    48,    51,     2,     2,
    39,     2,    68,    45,    51,    51,    51,    51,    51,    68,
    68,    68,    68,    68,     5,     5,     0,     0,    19,    19,
     5,    19,     0,    26,    26,    26,    26,    26,    12,    12,
    46,    12,    20,    20,    18,    16,    49,    50,    27,    11,
    54,    34,    57,    58,    59,    60,    61,    63,    65,    66,
     9,     8,    70,     7,     6,    23,    74,    77,    22,    82,
    86,     1,    47 ]

racc_action_pointer = [
    74,   121,    53,     3,   nil,    72,   106,   109,   109,    91,
   nil,    99,    83,   nil,   nil,   nil,    76,    24,    75,    73,
    90,   nil,   110,    96,   nil,   nil,    74,    96,    -2,   nil,
   nil,   nil,    41,    25,    99,    36,   nil,   nil,    44,    41,
   nil,   nil,   nil,   nil,   nil,    61,    71,   120,    43,    77,
    78,    55,    -1,   nil,    98,     5,   nil,   100,   101,    97,
   103,   104,   nil,   105,   nil,    90,   107,    26,    60,   nil,
   110,    38,    12,     0,    98,   nil,   nil,   110,     1,   nil,
   nil,   nil,   117,   nil,   nil,   nil,   118,    18,     2,   nil,
   nil ]

racc_action_default = [
   -55,   -55,    -1,   -55,    -5,   -55,    -7,    -9,   -11,   -55,
   -53,   -55,    -2,   -43,   -45,   -46,   -55,   -55,   -55,    -3,
   -55,    -6,    -8,   -55,   -54,   -10,   -55,   -55,   -12,   -14,
    91,   -44,   -55,   -55,   -55,    -4,   -15,   -18,   -20,   -55,
   -30,   -31,   -32,   -33,   -34,   -19,   -13,   -55,   -55,   -55,
   -55,   -55,   -21,   -29,   -55,   -16,   -47,   -55,   -55,   -55,
   -22,   -25,   -28,   -55,   -38,   -55,   -17,   -55,   -55,   -49,
   -55,   -23,   -26,   -55,   -40,   -41,   -48,   -55,   -55,   -24,
   -27,   -39,   -55,   -36,   -42,   -50,   -51,   -55,   -52,   -35,
   -37 ]

racc_goto_table = [
     5,    31,    61,    20,    37,    69,    81,     6,    28,    26,
     2,    60,    22,    19,    12,    46,    82,    33,    25,    74,
     3,     1,    81,    85,    31,   nil,    56,    45,    86,    59,
    62,    35,    48,   nil,    51,   nil,   nil,   nil,    52,   nil,
   nil,   nil,   nil,   nil,   nil,    76,    77,    55,   nil,    79,
    80,   nil,   nil,   nil,    66,   nil,   nil,    67,    68,   nil,
    71,    72,   nil,    73,   nil,   nil,   nil,   nil,   nil,   nil,
    78,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    87,   nil,   nil,   nil,    88 ]

racc_goto_check = [
     5,    20,    15,     5,    12,    23,    18,     6,     5,    11,
     2,    14,     6,     2,     3,    10,    17,     5,     8,    19,
     4,     1,    18,    23,    20,   nil,    12,     5,    15,    12,
    12,     3,     5,   nil,     5,   nil,   nil,   nil,     5,   nil,
   nil,   nil,   nil,   nil,   nil,    12,    12,     5,   nil,    12,
    12,   nil,   nil,   nil,     5,   nil,   nil,     5,     5,   nil,
     5,     5,   nil,     5,   nil,   nil,   nil,   nil,   nil,   nil,
     5,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,     5,   nil,   nil,   nil,     5 ]

racc_goto_pointer = [
   nil,    21,    10,    12,    20,     0,     7,   nil,    11,   nil,
   -13,     2,   -22,   nil,   -41,   -50,   nil,   -57,   -66,   -46,
   -11,   nil,   nil,   -54 ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil,   nil,    17,     7,   nil,     8,
   nil,   nil,   nil,    38,   nil,   nil,    39,   nil,    64,   nil,
    13,    14,    15,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 21, :_reduce_1,
  2, 21, :_reduce_2,
  2, 21, :_reduce_3,
  3, 21, :_reduce_4,
  1, 25, :_reduce_none,
  2, 25, :_reduce_none,
  1, 24, :_reduce_7,
  2, 24, :_reduce_8,
  1, 22, :_reduce_9,
  2, 22, :_reduce_10,
  1, 27, :_reduce_11,
  2, 27, :_reduce_12,
  3, 27, :_reduce_13,
  2, 29, :_reduce_14,
  3, 29, :_reduce_15,
  2, 30, :_reduce_16,
  3, 30, :_reduce_17,
  2, 28, :_reduce_18,
  2, 31, :_reduce_19,
  1, 32, :_reduce_20,
  2, 32, :_reduce_21,
  3, 32, :_reduce_22,
  4, 32, :_reduce_23,
  5, 32, :_reduce_24,
  3, 32, :_reduce_25,
  4, 32, :_reduce_26,
  5, 32, :_reduce_27,
  3, 32, :_reduce_28,
  2, 33, :_reduce_29,
  1, 36, :_reduce_none,
  1, 36, :_reduce_none,
  1, 36, :_reduce_none,
  1, 36, :_reduce_none,
  1, 36, :_reduce_none,
  5, 34, :_reduce_35,
  1, 37, :_reduce_36,
  3, 37, :_reduce_37,
  1, 35, :_reduce_38,
  3, 35, :_reduce_39,
  2, 38, :_reduce_40,
  1, 39, :_reduce_41,
  2, 39, :_reduce_42,
  1, 23, :_reduce_43,
  2, 23, :_reduce_44,
  1, 40, :_reduce_none,
  1, 40, :_reduce_none,
  4, 41, :_reduce_47,
  6, 41, :_reduce_48,
  5, 42, :_reduce_49,
  7, 42, :_reduce_50,
  3, 43, :_reduce_51,
  4, 43, :_reduce_52,
  1, 26, :_reduce_53,
  2, 26, :_reduce_54 ]

racc_reduce_n = 55

racc_shift_n = 91

racc_token_table = {
  false => 0,
  :error => 1,
  :NEWLINE => 2,
  :FEATURE => 3,
  :BACKGROUND => 4,
  :SCENARIO => 5,
  :OUTLINE => 6,
  :EXAMPLES => 7,
  :TAG => 8,
  :GIVEN => 9,
  :WHEN => 10,
  :THEN => 11,
  :AND => 12,
  :BUT => 13,
  :DOC_STRING_START => 14,
  :DOC_STRING_LINE => 15,
  :DOC_STRING_END => 16,
  :TABLE_ROW_START => 17,
  :TABLE_CELL => 18,
  :TEXT => 19 }

racc_nt_base = 20

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "NEWLINE",
  "FEATURE",
  "BACKGROUND",
  "SCENARIO",
  "OUTLINE",
  "EXAMPLES",
  "TAG",
  "GIVEN",
  "WHEN",
  "THEN",
  "AND",
  "BUT",
  "DOC_STRING_START",
  "DOC_STRING_LINE",
  "DOC_STRING_END",
  "TABLE_ROW_START",
  "TABLE_CELL",
  "TEXT",
  "$start",
  "Root",
  "Feature",
  "Scenarios",
  "FeatureTags",
  "Newline",
  "Tags",
  "FeatureHeader",
  "Background",
  "FeatureName",
  "Description",
  "BackgroundHeader",
  "Steps",
  "Step",
  "DocString",
  "Table",
  "Keyword",
  "DocStringLines",
  "TableRow",
  "TableCells",
  "Scenario",
  "SimpleScenario",
  "ScenarioOutline",
  "Examples" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'gherkin.y', 16)
  def _reduce_1(val, _values, result)
     result = val[0]; 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 19)
  def _reduce_2(val, _values, result)
     result = val[0]; result.scenarios = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 20)
  def _reduce_3(val, _values, result)
     result = val[1]; result.tags = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 22)
  def _reduce_4(val, _values, result)
     result = val[1]; result.scenarios = val[2]; result.tags = val[0] 
    result
  end
.,.,

# reduce 5 omitted

# reduce 6 omitted

module_eval(<<'.,.,', 'gherkin.y', 31)
  def _reduce_7(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 32)
  def _reduce_8(val, _values, result)
     result = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 35)
  def _reduce_9(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 37)
  def _reduce_10(val, _values, result)
     result = val[0]; result.background = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 41)
  def _reduce_11(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 42)
  def _reduce_12(val, _values, result)
     result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 44)
  def _reduce_13(val, _values, result)
     result = val[0]; result.description = val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 48)
  def _reduce_14(val, _values, result)
     result = AST::Feature.new(val[1]); result.pos(filename, lineno) 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 49)
  def _reduce_15(val, _values, result)
     result = AST::Feature.new(val[2]); result.pos(filename, lineno) 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 53)
  def _reduce_16(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 54)
  def _reduce_17(val, _values, result)
     result = val[0] << val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 59)
  def _reduce_18(val, _values, result)
     result = val[0]; result.steps = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 63)
  def _reduce_19(val, _values, result)
     result = AST::Background.new; result.pos(filename, lineno) 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 67)
  def _reduce_20(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 68)
  def _reduce_21(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 69)
  def _reduce_22(val, _values, result)
     val[0].doc_string = val[2]; result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 70)
  def _reduce_23(val, _values, result)
     val[0].doc_string = val[2]; result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 72)
  def _reduce_24(val, _values, result)
     val[0].doc_string = val[2]; val[4].unshift(val[0]); result = val[4] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 73)
  def _reduce_25(val, _values, result)
     val[0].table = val[2]; result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 74)
  def _reduce_26(val, _values, result)
     val[0].table = val[2]; result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 76)
  def _reduce_27(val, _values, result)
     val[0].table = val[2]; val[4].unshift(val[0]); result = val[4] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 77)
  def _reduce_28(val, _values, result)
     val[2].unshift(val[0]); result = val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 81)
  def _reduce_29(val, _values, result)
     result = AST::Step.new(val[1], val[0]); result.pos(filename, lineno) 
    result
  end
.,.,

# reduce 30 omitted

# reduce 31 omitted

# reduce 32 omitted

# reduce 33 omitted

# reduce 34 omitted

module_eval(<<'.,.,', 'gherkin.y', 89)
  def _reduce_35(val, _values, result)
     result = val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 93)
  def _reduce_36(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 94)
  def _reduce_37(val, _values, result)
     result = val[0] << val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 98)
  def _reduce_38(val, _values, result)
     result = [AST::TableRow.new(val[0])] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 99)
  def _reduce_39(val, _values, result)
     val[0] << AST::TableRow.new(val[2]); result = val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 103)
  def _reduce_40(val, _values, result)
     result = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 107)
  def _reduce_41(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 108)
  def _reduce_42(val, _values, result)
     result = val[0] << val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 112)
  def _reduce_43(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 113)
  def _reduce_44(val, _values, result)
     result = val[0] << val[1] 
    result
  end
.,.,

# reduce 45 omitted

# reduce 46 omitted

module_eval(<<'.,.,', 'gherkin.y', 123)
  def _reduce_47(val, _values, result)
     result = AST::Scenario.new(val[1], val[3]); result.pos(filename, lineno - 1) 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 126)
  def _reduce_48(val, _values, result)
     result = AST::Scenario.new(val[3], val[5], val[0]); result.pos(filename, lineno - 2) 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 131)
  def _reduce_49(val, _values, result)
     result = AST::ScenarioOutline.new(val[1], val[3], val[4]); result.pos(filename, lineno - 1) 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 134)
  def _reduce_50(val, _values, result)
     result = AST::ScenarioOutline.new(val[3], val[5], val[6], val[0]); result.pos(filename, lineno - 2) 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 139)
  def _reduce_51(val, _values, result)
     result = AST::ExamplesTable.new(val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 141)
  def _reduce_52(val, _values, result)
     result = AST::ExamplesTable.new(val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 145)
  def _reduce_53(val, _values, result)
     result = [AST::Tag.new(val[0])] 
    result
  end
.,.,

module_eval(<<'.,.,', 'gherkin.y', 146)
  def _reduce_54(val, _values, result)
     result = val[0] << AST::Tag.new(val[1]) 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module GherkinRuby
