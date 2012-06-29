require 'spec_helper'

describe Grammar do
  let(:rules) { mock() }
  let(:grammar) { Grammar.new(rules, EvaluationContext) }

  it 'evaluates existing rule' do
    rule = Rule.new(:some_rule) { produce { :expected_output } }

    rules.expects(:applying_for).returns([rule])

    grammar.evaluate(:some_rule).should == :expected_output
  end
end