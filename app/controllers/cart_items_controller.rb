class CartItemsController < ApplicationController
	before_action :authenticate_user!

	def destroy	
		@cart = current_cart
		@item = cart.cart_items.find_by(product_id: params[:id]) 
		@product = @item_product
		@item = destroy	

		flash[:warning] = "成功將#{@product.title}從購物車剔除"
		redirect_to :back
	end

	def update
		@cart = current_cart
		@item = @cart.find_cart_item(params[:id])

		if @item.product.quantity >= item_params[:quantity].to_i
			@item.update(item_params)
			flash[:notice] = "成功變更數量"
		else
			flash[:warning] = "庫存不足"
		end

		redirect_to carts_path
	end

	private
	def item_params
		params.require(:cart_item).permit(:quantity)
	end
end
