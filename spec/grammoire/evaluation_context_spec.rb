require 'spec_helper'

describe EvaluationContext do
  let(:grammar) { mock() }
  let(:context) { EvaluationContext.new(grammar) }

  it 'evaluate rule in context by evaluating from the grammar' do
    grammar.expects(:evaluate).with(:some_rule, {}).returns("some result")

    context.eval(:some_rule).should == "some result"
  end

  it 'raise error when access inexistent data point' do
    lambda { context.data(:dont_exist) }.should raise_error(GrammarError, "Data point 'dont_exist' doesn't exist in the evaluation context.")
  end

  it 'configures for rule evaluation' do
    context.for_evaluation(:some_rule, :point_a => "abc", :point_b => 123)

    context.rule_name.should == :some_rule
    context.data(:point_a).should == "abc"
    context.data(:point_b).should == 123
  end

  it 'forward data point when producing rule' do
    data = {:should => 'keep', :this => 'data'}
    context.for_evaluation(:any_rule, data)

    grammar.expects(:evaluate).with(:rule_with_data, data)

    context.eval(:rule_with_data)
  end
end