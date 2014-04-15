Blog::Admin.controllers :steps do
  
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
  
  get :new, :with=> :id do
    @recipe = Recipe.find(params[:id])
    @title = "create a new recipe"
    @step = Step.new
    render 'steps/new'

  end
  get :index do
    @title = "All steps"
    @step = Step.all

  end

  post :create  do
    @step = Step.new(params[:step])
    image = params[:step][:image]
    upload = Upload.new
    upload = image
    upload = File.open('public/images')
    if @step.save!
      @title = pat(:create_title, :model =>"step #{@step.id}")
      flash[:success] = pat(:create_success, :model=> 'step')
      params[:save_and_continue] ? redirect(url(:steps, :new, :id =>params[:step][:recipe_id])) : redirect(url(:steps, :edit, :id => @step.id))
    else
      @title = pat(:create_title, :model=>'recipe')
      flash.now[:error] = pat(:create_error, :model =>'recipe')
      redirect 'recipes/new'
    end

  end
  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "step #{ params[:id]}")
    @step = Step.find(params[:id])
    if @step
      render 'steps/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'step', :id =>"#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "step #{params[:id]}")
    @step = Recipe.find(params[:id])
    if @step
      if @step.update_attributes(params[:step])
        flash[:success] = pat(:update_success, :model => 'step', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:steps, :index)) :
          redirect(url(:steps, :edit, :id => @step.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'step')
        render 'steps/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'recipe', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Steps"
    step  = Step.find(params[:id])
    if step
      if step.destroy
        flash[:success] = pat(:delete_success, :model => 'step', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'step')
      end
      redirect url(:steps, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'step', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Step"
    unless params[:steps_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'step')
      redirect(url(:recipes, :index))
    end
    ids = params[:recipe_ids].split(',').map(&:strip)
    recipes  = Step.find(ids)
    
    if Recipe.destroy recipes
    
      flash[:success] = pat(:destroy_many_success, :model => 'step', :ids => "#{ids.to_sentence}")
    end
    redirect url(:steps, :index)
  end

end
