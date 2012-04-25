require 'spec_helper'

describe Production do
  it 'should hold an action block' do
    action = Proc.new {}

    production = Production.new(&action)

    production.action.should == action
  end

  it 'should evaluate action in the given context' do
    context = mock()
    context.expects(:inside_context).returns("context response")

    production = Production.new { inside_context }
    
    production.evaluate(context).should == "context response"
  end
end