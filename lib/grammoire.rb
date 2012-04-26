require File.expand_path(File.dirname(__FILE__) + '/grammoire/util/random_generator')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/grammar')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/production')
require File.expand_path(File.dirname(__FILE__) + '/grammoire/rule')

class GrammarError < StandardError; end

module Grammoire
  def self.define(&block)
    grammar = Grammar.new
    grammar.instance_eval &block
    grammar
  end
end