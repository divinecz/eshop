module StoreHelper
  
  def description
    @description || "Elektronický obchod – E-shop"
  end
  
  def keywords
    @keywords || "e-shop, elektronicky, obchod"
  end
  
  def hidden_div_if(condition, attributes = {}) 
    if condition 
      attributes["style"] = "display: none" 
    end 
    attrs = tag_options(attributes.stringify_keys) 
    "<div #{attrs}>" 
  end
end
