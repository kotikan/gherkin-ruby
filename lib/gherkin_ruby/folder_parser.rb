# @author: Anders Murphy

module GherkinRuby
  class FolderParser

    def parse_folder(path,feature_group_name)
      ast = GherkinRuby::AST::FeatureGroup.new(feature_group_name,[])
      parser =  GherkinRuby::Parser.new
      Dir[path << '*.feature'].each do |file|
        ast.features_and_feature_groups << parser.parse(File.read(file))
      end
      ast
    end

  end
end