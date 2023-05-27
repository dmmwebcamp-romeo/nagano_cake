class Public::ItemsController < ApplicationController
  def index
    @items= Item.page(params[:page]).per(8)
    @items_all =Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def genre_search
    @genre = Genre.find(params[:id])
    @items = @genre.items.all
    @genres = Genre.all
  end


  private

  def item_params
  params.require(:items).permit(:genre_id,:name,:description,:price)
  end

end
