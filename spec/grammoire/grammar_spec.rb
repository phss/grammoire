require 'spec_helper'

describe Grammar do
  let(:grammar) { Grammar.new }
  
  it 'should raise an exception when trying to produce output for non existent rule' do
    lambda { grammar.produce(:no_such_rule) }.should raise_error(GrammarError, "Rule 'no_such_rule' doesn't exist in the grammar.")
  end

end