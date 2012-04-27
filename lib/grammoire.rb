require File.expand_path(File.dirname(__FILE__) + '/grammoire/util/random_generator')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/grammar')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/production')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/rule')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/evaluation_context')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/production_chooser')

class GrammarError < StandardError; end

module Grammoire
  def self.define(&block)
    grammar = Grammar.new
    grammar.instance_eval &block
    grammar
  end
end