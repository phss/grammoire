require 'spec_helper'

describe Grammar do
  let(:grammar) { Grammar.new }

  it 'evaluates existing rule' do
    grammar.rule(:some_rule) { produce { :expected_output } }

    grammar.evaluate(:some_rule).should == :expected_output
  end
end