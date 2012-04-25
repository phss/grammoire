require 'spec_helper'

describe Production do

  it 'should evaluate action in the given context' do
    context = mock()
    context.expects(:inside_context).returns("context response")

    production = Production.new { inside_context }

    production.evaluate(context).should == "context response"
  end
end