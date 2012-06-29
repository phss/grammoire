require 'spec_helper'

describe GrammarBuilder do
  let(:builder) { GrammarBuilder.new }
  let(:grammar) { mock() }
  let(:rules) do
    rules = mock()
    Rules.stubs(:new).returns(rules)
    rules
  end
  let(:rule_chooser) do
    chooser = mock()
    RuleChooser.stubs(:new).returns(chooser)
    chooser
  end

  it 'builds a grammar with a set or rules, default context class and rule chooser' do
    Grammar.expects(:new).with(rules, EvaluationContext, rule_chooser).returns(grammar)
    
    builder.build.should == grammar
  end

  it 'allows overrding grammar evaluation context' do
    another_evaluation_context = mock() 

    Grammar.expects(:new).with(rules, another_evaluation_context, rule_chooser)

    builder.context(another_evaluation_context)
    builder.build
  end

  it 'constructs and insert a rule' do
    rule_setup_block = Proc.new { :setup_block }
    new_rule = mock()

    Rule.expects(:new).with(:rule_name, &rule_setup_block).returns(new_rule)
    rules.expects(:<<).with(new_rule)

    builder.rule(:rule_name, &rule_setup_block)
  end
  
end