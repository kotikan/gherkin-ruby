# Compile with: rex scenario.rex -o scenario_lexer.rb

class GherkinRuby::ScenarioParser

macro
  BLANK         [\ \t]+
  TABLE_SEP     \|
  DOCSTR_SEP    "{3}

rule
  # Whitespace
            {BLANK}         # no action
            \#.*$

  # Literals
            \n              { [:NEWLINE, text] }

  # Keywords
            Scenario:       { [:SCENARIO, text[0..-2]] }
            Scenario{BLANK}Outline:   { [:OUTLINE, text[0..-2]] }
            Examples:       { [:EXAMPLES, text[0..-2]] }

  # Tags
            @(\w|-)+        { [:TAG, text[1..-1]] }

  # Step keywords
            Given           { [:GIVEN, text] }
            When            { [:WHEN, text] }
            Then            { [:THEN, text] }
            And             { [:AND, text] }
            But             { [:BUT, text] }

  # Tables
            {TABLE_SEP}     { @state = :TABLE ; [:TABLE_ROW_START, text] }
  :TABLE    {TABLE_SEP}
  :TABLE    (?=[#\n])       { @state = nil }
  :TABLE    [^#\n\|]*       { [:TABLE_CELL, text.strip] }

  # Doc strings
            {DOCSTR_SEP}            { @state = :DOCSTR ; [:DOC_STRING_START, text] }
  :DOCSTR   {BLANK}
  :DOCSTR   \n                      { [:NEWLINE, text] }
  :DOCSTR   {DOCSTR_SEP}            { @state = nil ; [:DOC_STRING_END, text] }
  :DOCSTR   [^\n{DOCSTR_SEP}]*      { [:DOC_STRING_LINE, text] }

  # Text
            [^#\n]*         { [:TEXT, text.strip] }

inner
  def tokenize(code)
    scan_setup(code)
    tokens = []
    while token = next_token
      tokens << token
    end
    tokens
  end

end
