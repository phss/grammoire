require 'spec_helper'

describe Rules do
  let(:context) do
    any_context = mock()
    any_context.stubs(:rule_name).returns(:any_context)
    any_context
  end

  let(:rules) { Rules.new }

  it 'returns list of rules that can be applied in the given context' do
    valid_rule, another_valid, invalid_rule = with_applicable_rule, with_applicable_rule, with_unapplicable_rule
    
    rules.applying_for(context).should =~ [valid_rule, another_valid]
  end

  it 'raises an error when no rule exists' do
    lambda { rules.applying_for(context) }.should raise_error(GrammarError, "Rule 'any_context' doesn't exist or don't have valid pre-conditions.")
  end

  it 'raises an error if no rule applies for given context' do
    with_unapplicable_rule

    lambda { rules.applying_for(context) }.should raise_error(GrammarError, "Rule 'any_context' doesn't exist or don't have valid pre-conditions.")
  end

  def with_applicable_rule
    rule_applies(true)
  end

  def with_unapplicable_rule
    rule_applies(false)
  end

  def rule_applies(should_apply)
    rule = mock()
    rule.expects(:applies?).with(context).returns(should_apply)
    rules << rule
    return rule
  end

end