class AddRelationshipToImage < ActiveRecord::Migration
  def change
		add_reference :images, :item
  end
end
