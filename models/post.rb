class Post < ActiveRecord::Base
  
  attr_accessible :image, :image_cache, :remove_image, :title, :body, :account_id, :post_id
  belongs_to :account
  has_one :recipe
  has_many :comments, dependent: :destroy
#  has_one :recipe, :dependent: :destroy

  validates_presence_of :title
  validates_presence_of :body
  before_save  :make_slug
 # mount_uploader :image, Uploader
  scope :for_year,  lambda {|year| where('STRFTIME("%Y",created_at) = ?',year)}
  scope :for_month,  lambda {|month| where('STRFTIME("%m",created_at) = ?',month)}
  def to_param
    slug
  end
  def make_month(t)
    self.for_month

  end
  def slug
    title.gsub(" ","-")
  end
  private
    def make_slug
      self.slug = slug
    end
 end
