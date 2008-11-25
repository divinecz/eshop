class StoreController < ApplicationController

  before_filter :load_cart, :except => :empty_cart

  def index
    @products = Product.find_all_for_sale
  end
  
  def product
    @product = Product.find(params[:id])
    @keywords = @product.all_keywords.join(', ')
    @description = @product.description
    @title = @product.title
  end
  
  def catalog
    unless params[:category]
      redirect_to root_path
      return
    end

    @category = Category.find(params[:category])
    @description = @category.description
    @keywords = @category.all_keywords.join(', ')
    @products = @category.all_products_for_sale
    @manufacturers = @products.collect(&:manufacturer).uniq
    @title = @category.has_parent? ? [@category.all_parents.collect(&:title).join(' – '), @category.title].join(' – ') : @category.title
    
    if request.post?
      @filter = CatalogFilter.new(params[:filter]) 
      @products = @filter.apply @products
    end
  end
  
  def place_order
    if session[:user_id]
      @order = Order.new(params[:user])
      @order.user = @user = User.find(session[:user_id])
      @order.add_line_items_from_cart(@cart)
      
      if @order.save
        PostOffice.deliver_order(@user, @order)
        session[:cart] = nil
        redirect_to_index("Objednavka byla odeslána k zpracování.")
      else
        render :action => "checkout"
      end
    else
      @user = User.new(params[:user])
      @order = Order.new(params[:user])
      @order.user = @user
      @order.add_line_items_from_cart(@cart)
      
      if @user.save && @order.save
        PostOffice.deliver_signup(@user)
        PostOffice.deliver_order(@user, @order)
        session[:cart] = nil
        session[:user_id] = User.authenticate(@user.email, @user.password)
        redirect_to_index("Objednavka nazdar!")
      else
        render :action => "checkout"
      end
    end
  end
  
  def checkout
    if @cart.size.zero?
      redirect_to_index("Nelze potvrdit objednávku—košík je prázdný!", 3) 
    else 
      @user = User.find_by_id(session[:user_id])
    end
  end
  
  def add_to_cart
    begin
      product = Product.find_for_sale(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("\n\n#{request.env['REMOTE_ADDR']}\nAttempt to access invalid product #{params[:id]}\n\n")
      redirect_to_index("Neplatny produkt", 3) 
      #TODO: zustane adresa, ale vypise se index render :action => "index" nebo referer?
    else
      @item = @cart.add(product)
      redirect_to :back unless request.xhr?
    end
  end
  
  def update_cart
    @cart.update_cart params[:quantities]
    redirect_to request.env['HTTP_REFERER'] unless request.xhr?
  end
  
  def remove_cart_item
    @cart.remove(params[:id])
    redirect_to_index unless request.xhr?
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index unless request.xhr?
  end
  
  protected
  def load_cart
    @cart = (session[:cart] ||= Cart.new)
    @categories = Category.find_all_top_categories
  end
end
