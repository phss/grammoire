require 'spec_helper'

describe Rule do
  let(:context) { mock() }
  let(:rule) { Rule.new(:rule_name) }

  it 'should construct rule with a setup block' do
    rule = Rule.new(:my_name) do
      weights 5
      produce { 'production' }
    end

    rule.name.should == :my_name
    rule.weight == 5
    rule.evaluate('any context').should == 'production'
  end

  describe '(weighting)' do
    it 'should have default weight of 1' do
      rule.weight.should == 1
    end

    it 'should allow changing the weight' do
      rule.weights(3)

      rule.weight.should == 3
    end
  end

  describe '(conditions)' do
    it 'should always applies when pre conditions not specified' do
      rule.applies?(context).should be_true
    end

    it 'should apply only if pre condition is valid within context' do
      context.expects(:data).with(:number).returns(30)

      rule.pre_condition { data(:number) == 30 }

      rule.applies?(context).should be_true
    end

    it 'should not apply if pre condition is invalid within context' do
      context.expects(:data).with(:number).returns(42)
      
      rule.pre_condition { data(:number) == 30 }

      rule.applies?(context).should be_false
    end
  end

  describe '(evaluation)' do
    it 'should evaluate production in the given context' do
      context.expects(:inside_context).returns('context response')

      rule.produce { inside_context }

      rule.evaluate(context).should == 'context response'
    end
  end

end