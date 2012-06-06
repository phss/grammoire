require 'spec_helper'

describe Rule do
  let(:context) { mock() }
  let(:context_for_rule) { context.stubs(:rule_name).returns(rule.name); context }

  let(:rule) { Rule.new(:rule_name) }

  it 'constructs rule with a setup block' do
    rule = Rule.new(:my_name) do
      weights 5
      produce { 'production' }
    end

    rule.name.should == :my_name
    rule.weight == 5
    rule.evaluate('any context').should == 'production'
  end

  describe '(weighting)' do
    it 'has default weight of 1' do
      rule.weight.should == 1
    end

    it 'allows changing the weight' do
      rule.weights(3)

      rule.weight.should == 3
    end
  end

  describe '(conditions)' do
    it 'always applies when rule name matches context rule and pre conditions not specified' do
      context.expects(:rule_name).returns(rule.name)

      rule.applies?(context).should be_true
    end

    it 'applies if pre condition is valid within context' do
      context_for_rule.expects(:data).with(:number).returns(30)

      rule.pre_condition { data(:number) == 30 }

      rule.applies?(context_for_rule).should be_true
    end

    it 'doesnt apply if context is for a different rule' do
      context.expects(:rule_name).returns(:another_rule)

      rule.applies?(context).should be_false
    end

    it 'doesnt apply if pre condition is invalid within context' do
      context_for_rule.expects(:data).with(:number).returns(42)
      
      rule.pre_condition { data(:number) == 30 }

      rule.applies?(context_for_rule).should be_false
    end
  end

  describe '(evaluation)' do
    it 'evaluates production in the given context' do
      context_for_rule.expects(:inside_context).returns('context response')

      rule.produce { inside_context }

      rule.evaluate(context_for_rule).should == 'context response'
    end
  end

end