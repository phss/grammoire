require 'spec_helper'

describe Grammar do
  let(:rules) { mock() }
  let(:context_class) { mock() }
  let(:context) do 
    mocked_context = mock()
    context_class.stubs(:new).returns(mocked_context)
    mocked_context
  end
  let(:rule_chooser) { mock() }
  let(:grammar) { Grammar.new(rules, context_class, rule_chooser) }

  it 'evaluates a rule by name' do
    filtered_rules = mock()
    selected_rule = mock()

    context.expects(:for_evaluation).with(:some_rule, {})
    
    rules.expects(:applying_for).with(context).returns(filtered_rules)
    rule_chooser.expects(:select_from).with(filtered_rules).returns(selected_rule)
    selected_rule.expects(:evaluate).with(context)

    grammar.evaluate(:some_rule)
  end
end