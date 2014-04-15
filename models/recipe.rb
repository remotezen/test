class Recipe < ActiveRecord::Base
  attr_accessible :image, :image_cache, :remove_image,
    :title, :course, :prep_time, :cooking_time, :main_ingredient,:post_id, :slug,
    :content

  has_many :steps, :dependent => :destroy
  has_many :toppings, :dependent => :destroy
  belongs_to :post
  before_save :make_slug
  #validates_presence_of :title, :uniqueness => true
  validates_presence_of :course
  validates_presence_of :prep_time
  validates_presence_of :cooking_time
  validates_presence_of :slug, :uniqueness => true
  validates_presence_of :main_ingredient
  validates_presence_of :content
  validates_presence_of :image

  #mount_uploader :image, Uploader
  
  def to_param
    slug
  end
  def slug
   title.gsub(" ","-") 
  end
  def make_slug
    self.slug = slug
  end
end
