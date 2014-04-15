Blog::App.controllers :search do
  post :create do
    @title = "Jo Goes Green Search Results"
    q  = params[:search]
    #@search = Post.find(:all, :conditions => ["body like  ? or title like ?", "%#{q}","%#{q}"] ).page(params[:page]).per_page(10)
    #@search = Post.find(:all, :conditions => ["body like  ? or title like ?", q,q] ).page(params[:page]).per_page(10)
   # @search = Post.find(:all, :conditions => ["lower(body) like  lower(?) or lower(title) like lower(?)","%#{q}%", "%#{q}%"] ).page(params[:page]).per_page(10)
    @search = Post.find(:all,:conditions => ["lower(body) like  lower(?) or lower(title) like lower(?)","%#{q}%","%#{q}%"]).paginate(:page=>params[:page],:per_page=>10)

    render 'search/search'

#@search = ThinkingSphinx.search params[:search], :classes => [Post, Comment, Recipe]
=begin
    @search = ThinkingSphinx.search params[:search],
      :page=> params[:page], :per_page => 9, 
      :classes => [Post, Comment, Recipe]
=end      

  end    
  get :create  do

    @title = "Jo Goes Green Search results page #{params[:page] }"
=begin    
    q  = params[:search]
    @search = Post.find(:all, :conditions => ["body like  ? or title like ?",q,q])
    render 'search/search'
    @search = Post.find(:all, :conditions => ["body like  ? or title like ?", q,q] )
    render 'search/search'
=end    

#@search = ThinkingSphinx.search params[:search], :classes => [Post, Comment, Recipe]
=begin    #
    @search = ThinkingSphinx.search params[:search],
      :page=> params[:page], :per_page => 9, 
      :classes => [Post, Comment, Recipe]
=end      
    @search = Post.paginate(:page => params[:page],:per_page=>10).order("id DESC")
    render 'search/search'    

  end    
  

end
