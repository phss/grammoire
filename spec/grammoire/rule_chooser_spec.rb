require 'spec_helper'

describe RuleChooser do
  let(:generator) { StubRandomGenerator.new }
  let(:chooser) { RuleChooser.new(generator) }

  it 'should return nil if no rule is given' do
    chooser.select_from([]).should be_nil
  end

  it 'should select only rule if only one rule is given' do
    generator.returning_results(0, 1)

    rule = Rule.new(:name)

    chooser.select_from([rule]).should == rule
  end

  it 'should select rule based on the probability over the weightings' do
    generator.returning_results(0, 1, 2, 3)

    heavier_rule = Rule.new(:heavy) { weights 3 }
    lighter_rule = Rule.new(:heavy) { weights 1 }
    rules = [heavier_rule, lighter_rule]
    
    chooser.select_from(rules).should == heavier_rule
    chooser.select_from(rules).should == heavier_rule
    chooser.select_from(rules).should == heavier_rule
    chooser.select_from(rules).should == lighter_rule
  end

end