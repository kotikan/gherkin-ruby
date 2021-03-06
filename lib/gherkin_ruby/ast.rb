module GherkinRuby
  module AST
    class Node
      attr_reader :filename, :line

      def accept(visitor)
        name = self.class.name.split('::').last
        visitor.send("visit_#{name}".to_sym, self)
      end

      def pos(filename, line=nil)
        @filename, @line = filename, line
      end
    end

    class FeatureGroup < Node
      attr_reader :name, :features_and_feature_groups
      attr_writer :features_and_feature_groups

      include Enumerable

      def initialize(name, features_and_feature_groups=[])
        @name     = name
        @features_and_feature_groups = features_and_feature_groups
      end

      def each
        if block_given?
          @features_and_feature_groups.each {|feature_or_feature_group| yield feature_or_feature_group}
        else
          @features_and_feature_groups.each
        end
      end
    end

    class Feature < Node
      attr_reader :name, :background, :scenarios, :tags
      attr_writer :background, :scenarios, :tags
      attr_accessor :description

      include Enumerable

      def initialize(name, scenarios=[], tags=[], background=nil)
        @name       = name
        @background = background
        @tags       = tags
        @scenarios  = scenarios
      end

      def each
        if block_given?
          @scenarios.each {|scenario| yield scenario}
        else
          @scenarios.each
        end
      end
    end

    class Background < Node
      attr_reader :steps
      attr_writer :steps

      include Enumerable

      def initialize(steps=[])
        @steps = steps
      end

      def line
        @steps.first.line - 1 if @steps.any?
      end

      def each
        if block_given?
          @steps.each {|step| yield step}
        else
          @steps.each
        end
      end
    end

    class Scenario < Node
      attr_reader :name, :steps, :tags

      include Enumerable

      def initialize(name, steps=[], tags=[])
        @name  = name.to_s
        @steps = steps
        @tags  = tags
      end

      def line
        @steps.first.line - 1 if @steps.any?
      end

      def each
        if block_given?
          @steps.each {|step| yield step}
        else
          @steps.each
        end
      end
    end

    class ScenarioOutline < Scenario
      attr_reader :examples

      include Enumerable

      def initialize(name, steps=[], examples=[], tags=[])
        super name, steps, tags

        @examples = examples
      end
    end

    class Step < Node
      attr_reader :name, :keyword
      attr_accessor :doc_string, :table
      def initialize(name, keyword)
        @name    = name.to_s
        @keyword = keyword.to_s
        @doc_string = nil
        @table = nil
      end
    end

    class Tag < Node
      attr_reader :name
      def initialize(name)
        @name = name
      end
    end

    class ExamplesTable < Node
      attr_writer :rows

      include Enumerable

      def initialize(rows=[])
        @rows = rows
      end

      def line
        @rows.first.line - 1 if @rows.any?
      end

      def each
        if block_given?
          @rows.each { |row| yield row }
        else
          @rows.each
        end
      end
    end

    class TableRow < Node
      attr_writer :cells

      include Enumerable

      def initialize(cells=[])
        @cells = cells
      end

      def each
        if block_given?
          @cells.each { |cell| yield cell }
        else
          @cells.each
        end
      end
    end
  end
end
