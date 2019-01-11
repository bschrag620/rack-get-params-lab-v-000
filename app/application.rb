class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.size == 0
        resp.write "Your cart is empty"
      else
        @@items.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      new_item = req.params['q']
      resp.write add_item(new_item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
  
  def add_item(new_item)
    if @@items.include?(new_item)
      @@cart << new_item
      "#{new_item} added to cart"
    else
      "#{new_item} not found."
    end
  end
end
