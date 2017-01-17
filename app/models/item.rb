class Item < ActiveRecord::Base
  #attr_accessible :price, :name, :real, :weight, :description

validates :price, numericality: {greater_than: 0, allow_nil:true}

validates :name, :description, presence: true

has_many :positions
has_many :carts, through: :positions

has_many :comments, as: :commentable
has_one  :image

#def image=(i)
	
	#if !image || !new_record?
		#@image = Image.create(i.merge({imageable: self}))
	#end
 #end

#def save_image
#end

#belongs_to :category

#after_initialize {} #Item.new;Item.first
#after_save {} Item.save;Item.create;Item.update_attributes()
#after_create {}
#after_update {}
#after_destroy {} #Item.destroy
end
