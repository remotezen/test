Blog::Admin.controllers :comments do
  #retrive all the comments by all the users and blogs
 
  get :index do
    @title = "All Comments"
    @comments  = Comment.paginate(:page => params[:page], :per_page=>15)
    render 'comments/index'
  end
  
  get :show , :with => :id do
    @title = pat(:new_title, model:'comment')
    @title = "Comment"
    @comment = Comment.find(params[:id])
    render 'comments/show'
  end

  delete :destroy, :with => :id do
    @title = "Comments"
    c = Comment.find(params[:id])
    if c
      if c.destroy
        flash[:success] = pat(:delete_success, :model => 'Comment', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'comment')
      end
      redirect url(:posts, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'comment', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Comments"
    unless params[:comments_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'Comments')
      redirect(url(:comments, :index))
    end
    ids = params[:comment_ids].split(',').map(&:strip)
    c  = Comment.find(ids)
    
    if Comment.destroy c 
      flash[:success] = pat(:destroy_many_success, :model => 'Comments', 
                            :ids => "#{ids.to_sentence}")
    end
    redirect url(:comments, :index)
  end
  get :find_many do
    @account = Account.find(params[:id])
    @title = "Comments by #{@account.user_name}"
    @comments = Comment.where("account_id = ?", params[:id])
    render 'comments/index'
  end
end
  

