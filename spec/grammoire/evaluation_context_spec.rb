require 'spec_helper'

describe EvaluationContext do
  let(:grammar) { mock() }
  let(:context) { EvaluationContext.new(grammar) }

  it 'should produce rule in context by evaluating from the grammar' do
    grammar.expects(:produce).with(:some_rule).returns("some result")

    context.produce(:some_rule).should == "some result"
  end

end