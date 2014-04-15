Blog::App.controllers :blog do
  get :rss  do
    @title = "Blog"
    @posts = Post.all
    
    builder  :rss 
  end
  get :index do
    @title = "All Posts"
    @posts = Post.all
  end
  get :archive, :with=>[:id,:month] do
    
    @id = params[:id]
    @month =params[:month]
    @name = "Post"
    @arr = @id.split('-')
    y = @arr[0]
    m = @arr[1]
    @archive = Post .where("MONTH(created_at) = ? and YEAR(created_at) = ?", m,y).order('id DESC')
    @count = @archive.count
    render 'shared/archive'
  
  end
  
  
  get :show , :with=> :id do 
    if is_pjax?
      render :layout => false
    end
    @post = Post.find_by_slug(params[:id])
    @comments = Comment.where("post_id = #{@post.id}").paginate(:page=>params[:page],:page => 1, 
                                                :per_page=>20).order('id DESC')

    render 'blog/show'
  end
  
  
  get :home, :map => '/' do
    if is_pjax?
      render :layout => false
    end
    @posts  = Post.find(:all, :limit=> 20, :order=>'id desc')
   #dotenv values 
    h1 = geo_hash(Geocoder.search(ENV["HOME_IP"]).first.data)
    h2 = geo_hash(Geocoder.search(ENV["HOME_IP"]).first.data)
    @home = distance_between(h1,h2)
    #post_months = @posts.group_by{|t|t.created_at.beginning_of_month }  
    #month = Date.strftime('%m','created_at')
=begin    #
    recipes  = Recipe.find(:all, :limit => 5, :order=> 'id desc')
    post_months = @posts.group_by{|t|t.created_at.beginning_of_month 
    }  
    recipe_months = recipes.group_by{|t|t.created_at.beginning_of_month }  
    comments = Comment.find(:all,  :order=> 'id desc')
    comment_months = comments.group_by{|t|t.created_at.beginning_of_month}  
    Blog::App.cache.set('post_months',post_months)
    Blog::App.cache.set('recipe_months',recipe_months)
    Blog::App.cache.set('comment_months',comment_months)
    Blog::App.cache.set('comments',comments)
=end    
     @post = Post.last
     #@date = @post.created_at.to_s.split('-').to_a
     #@day = @date[2].split(' ')
     Comment.paginate(:page => params[:page]).order('created_at DESC')
     @comments = Comment.where("post_id = #{@post.id}").paginate(:page=>params[:page],:page => 1, 
                                                :per_page=>20).order('id DESC')
     render 'blog/home'
  end
  get :image, :with=>:id do
    @image = Post.find_by_slug(params[:id])
    @image.image
  end
end
