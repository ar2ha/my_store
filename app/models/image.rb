class Image < ActiveRecord::Base

#attr_accessible :photo
has_attached_file :photo
belongs_to :item
end
