require 'spec_helper'

describe Production do
  it 'should hold an action block' do
    action = Proc.new {}

    production = Production.new(action)

    production.action.should == action
  end
end