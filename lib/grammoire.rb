require File.expand_path(File.dirname(__FILE__) + '/grammoire/util/random_generator')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/grammar_builder')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/grammar')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/rule')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/rules')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/evaluation_context')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/rule_chooser')

class GrammarError < StandardError; end

module Grammoire
  def self.define(&block)
    builder = GrammarBuilder.new
    builder.instance_eval &block
    builder.build
  end
end