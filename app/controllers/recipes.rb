Blog::App.controllers :recipes do
  get :show, :with => :id do
    @recipe = Recipe.find_by_slug(params[:id])
    render 'recipes/show'
  end
  get :index do
    if logged_in?
    @title = "All your recipes"
    @recipes = Recipe.order('created_at DESC').page(params[:page]).per_page(10)
    render 'recipes/index' 
    else
      render url_for(:logins,:new)
    end
  end
  get :archive, :with => [:id, :month] do
    @id = params[:id]
    @month = params[:month]
    @arr = @id.split('-')
    y = @arr[0]
    m = @arr[1]
    @name = "Recipe"
    @archive = Recipe .where("MONTH(created_at) = ? and YEAR(created_at) = ?", m,y).order('id DESC')
    @count = @archive.count
    render 'shared/archive'
  end

  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  

end
