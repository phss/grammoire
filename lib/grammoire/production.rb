class Production
  attr_reader :action

  def initialize(&action)
    @action = action
  end 

  def evaluate(context)
    context.instance_eval &@action
  end
  
end