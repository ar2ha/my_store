class ItemsController < ApplicationController

 before_filter :find_item, only: [:show, :edit, :update, :destroy, :upvote]

 before_filter :check_if_admin, only: [:edit, :update, :destroy, :new, :create]

 before_filter :authenticate_user!, except: :index

def index
	@items = Item
	@items = Item.where("price >=?", params[:price_from]) if params[:price_from]
	
	@items = @items.where("created_at >=?", 1.day.ago) if params[:today]
	
	@items = @items.where("votes_count >=?", params[:votes_from]) if params[:votes_from]
	
	@items = @items.order("votes_count DESC", "price")

	#@items = @items.includes(:image)
	#render "items/index" не обязательно вводить
end

def expensive
	@items = Item.where("price > 1000")
	render "index"
end

#/items/1 GET
def show

 unless @item #= Item.where(id: params[:id]).first - это в фильтре
	#render "items/show"   можно не вводить
 #else
	render text: "Page not found", status: 404
end
end

#/items/new GET
def new
	@item = Item.new
end

#/items/1/edit GET
def edit
	#@item = Item.find(params[:id]) - в фильтре
end

#/items POST
def create
		  @item = Item.create(item_params)
	 if @item.errors.empty?
			@item.image.create(item_photo_params)
			redirect_to item_path(@item, admin: 1)
	 else
		render "new"		 
end
end

#/items/1 PUT
def update
			#@item = Item.find(params[:id]) - в фильтре
		  @item.update_attributes(item_params)
	 if @item.errors.empty?
			flash[:success] = "Item successfully updated!"
			redirect_to item_path(@item, admin: 1)
	 else
			flash.now[:error] = "You made mistakes in your form! Please correct them "
			render "edit"	
end
end

#/items/1 DELETE
def destroy
		#@item = Item.find(params[:id])- в фильтре
		@item.destroy
		redirect_to action: "index", admin: 1
end

def upvote
	@item.increment!(:votes_count)
	redirect_to action: :index
end

private

def find_item
	@item = Item.where(id: params[:id]).first
	render_404 unless @item
	end

def item_params
	params.require(:item).permit(:price, :weight, :real, :name, :description)
end

def item_photo_params
	params.require(:item).permit(:photo)	
end
 end
