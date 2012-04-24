class Grammar
  
  def produce(rule)
    raise GrammarError.new("Rule '#{rule}' doesn't exist in the grammar.")
  end

end