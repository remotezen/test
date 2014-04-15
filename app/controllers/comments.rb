Blog::App.controllers :comments do
  get :archive, :with => [:id,:month] do
    @id = params[:id]
    @month= params[:month]
    @arr = @id.split('-')
    y = @arr[0]
    m = @arr[1]
    @name = "Comment"
    @archive = Comment.where("MONTH(created_at) = ? and YEAR(created_at) = ?", m,y).order('id DESC')
    @count = @archive.count
    render 'shared/archive'
  end
  
  get  :new, :with=> :id  do

    if is_pjax?
      render :layout => false
    end
    if logged_in?
      @comment = Comment.new
      render  'comments/new', :layout => !is_pjax?
    else
      redirect_to url_for(:logins,:new) 
    end
  end 
  
  get :show , :with => :id do
    @comment = Comment.find_by_slug(params[:id])
    render 'comments/show'
  end
  
  post :create do
    id = params[:post_id]
    @post = Post.find(id)
     @comment  = @post.comments.build(:comment =>  params[:comment], :account_id => params[:account_id])
     if @comment.save
       redirect_to  url_for(:blog, :show, :id=>@post.slug) 
    else
      alert('User is not valid');
    end
  end

end
 # escape_javascript(render('users/unfollow')
