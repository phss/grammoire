require 'spec_helper'

describe Production do

  it 'should evaluate action in the given context' do
    context = mock()
    context.expects(:inside_context).returns("context response")

    production = Production.new(1) { inside_context }

    production.evaluate(context).should == "context response"
  end

  it 'should define a weight for evaluating the production' do
    production = Production.new(32)

    production.weight.should == 32
  end

  it 'should construct production through an options map' do
    production = Production.from(:weight => 4) { evaluation }

    production.weight.should == 4
  end
end